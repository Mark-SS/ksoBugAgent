//
//  KSOBugAgent.m
//  TestTDD
//
//  Created by gongliang on 2018/7/24.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import "KSOBugAgent.h"
#import <pthread.h>
#import "KSODevice.h"
#import "NSObject+KSOSwizzle.h"
#import "UIViewController+KSOBugAgent.h"
@import UIKit;

#define KSOBugAgentTrackInfoMaxCount 20

@interface KSOBugAgent() {
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMutableArray *crashTracks;  // 崩溃轨迹追踪，默认追踪 20 条
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) KSODevice *device;
@property (nonatomic, strong) NSDictionary *deviceInfo;

@end

@implementation KSOBugAgent

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    pthread_mutex_destroy(&_lock);
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static KSOBugAgent *bugAgent;
    dispatch_once(&onceToken, ^{
        bugAgent = [[KSOBugAgent alloc] init];
    });
    return bugAgent;
}

- (instancetype)init {
    if (self = [super init]) {
        pthread_mutex_init(&_lock, NULL);
        _crashTracks = [[NSMutableArray alloc] initWithCapacity:KSOBugAgentTrackInfoMaxCount];
        [self setUpListeners];
        [self getDeviceInfo];
        [UIViewController kso_swizzleSEL:@selector(viewWillAppear:)
                                 withSEL:@selector(kso_bugAgent_viewWillAppear:)];
    }
    return self;
}

#pragma mark - Public
- (void)start {
    NSSetUncaughtExceptionHandler(&caughtExceptionHandler);
}

+ (void)start {
    [[KSOBugAgent sharedInstance] start];
}

- (void)trackViewWillAppear:(UIViewController *)viewController {
    if (!viewController) {
        return ;
    }
    Class class = [viewController class];
    if (!class) {
        return ;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"UINavigationController")]) {
        return ;
    }
    
    NSString *controllerName = NSStringFromClass(class);
    // 获取 controller.navigationItem.title
    NSString *itemTitle = viewController.navigationItem.title;
    
    NSString *trackString = [NSString stringWithFormat:@"【%@ %@】WillAppear", controllerName, itemTitle ?: @""];
    [self addTrackInfo:trackString];
}

void caughtExceptionHandler(NSException *exception) {
    // 获取异常崩溃信息
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];

    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:\n%@\nreason:\n%@callStackSymbols:\n%@", name, reason, [callStack componentsJoinedByString:@"\n"]];
    NSLog(@"%@ \n", content);
    NSLog(@"====> 跟踪流程：\n%@\n",  [[[KSOBugAgent sharedInstance] crashTracks] componentsJoinedByString:@"\n"]);
    NSLog(@"========异常错误报告 end==========");
}

#pragma mark - Private
- (void)setUpListeners {
    // 监听 App 启动或结束事件
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(applicationWillEnterForeground:)
                               name:UIApplicationWillEnterForegroundNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidBecomeActive:)
                               name:UIApplicationDidBecomeActiveNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(applicationWillResignActive:)
                               name:UIApplicationWillResignActiveNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidEnterBackground:)
                               name:UIApplicationDidEnterBackgroundNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(applicationWillTerminateNotification:)
                               name:UIApplicationWillTerminateNotification
                             object:nil];
}

- (void)addTrackInfo:(NSString *)info {
    if (!info) {
        return ;
    }
    NSDate *date = [NSDate date];
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    NSString *temp = [NSString stringWithFormat:@"%@ %@", dateString, info];
    
    pthread_mutex_lock(&_lock);
    if (self.crashTracks.count >= KSOBugAgentTrackInfoMaxCount) {
        [self.crashTracks removeObjectAtIndex:0];
    }
    [self.crashTracks addObject:temp];
    pthread_mutex_unlock(&_lock);
}

- (void)getDeviceInfo {
    KSODevice *device = self.device;
    NSDictionary *info = @{@"systemName": device.systemName,
                           @"systemVersion": device.systemVersion,
                           @"deviceModel": device.deviceModel,
                           @"appVersion": device.appVersion,
                           @"freeMemory": [NSString stringWithFormat:@"%.2f MB", device.getFreeMemory / 1024.0 / 1024.0],
                           @"freeDisk": [NSString stringWithFormat:@"%.2f MB", device.getFreeDiskSpace / 1024.0 / 1024.0]
                           };
    self.deviceInfo = info;
}

#pragma mark - properties
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormatter;
}

- (KSODevice *)device {
    if (!_device) {
        _device = [KSODevice new];
    }
    return _device;
}

#pragma mark - app 通知

/**
 触发时机：程序进入前台，但是还没有处于活动状态时调用。
 适宜操作：这个阶段应该恢复用户数据。
 */
- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSString *trackString = [NSString stringWithFormat:@"【UIApplication】WillEnterForeground"];
    [self addTrackInfo:trackString];
}

/**
 触发时机：程序进入前台并处于活动状态时调用。
 适宜操作：这个阶段应该恢复UI状态（例如游戏状态）。
 */
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    NSString *trackString = [NSString stringWithFormat:@"【UIApplication】DidBecomeActive"];
    [self addTrackInfo:trackString];
}

/**
 触发时机：从活动状态进入非活动状态。
 适宜操作：这个阶段应该保存UI状态（例如游戏状态）。
 */
- (void)applicationWillResignActive:(NSNotification *)notification {
    NSString *trackString = [NSString stringWithFormat:@"【UIApplication】WillResignActive"];
    [self addTrackInfo:trackString];
}

/**
 触发时机：程序进入后台时调用。
 适宜操作：这个阶段应该保存用户数据，释放一些资源（例如释放数据库资源）。
 */
- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSString *trackString = [NSString stringWithFormat:@"【UIApplication】DidEnterBackground"];
    [self addTrackInfo:trackString];
}

/**
 触发时机：程序被杀死时调用。
 适宜操作：这个阶段应该进行释放一些资源和保存用户数据。
 */
- (void)applicationWillTerminateNotification:(NSNotification *)notification {
    NSString *trackString = [NSString stringWithFormat:@"【UIApplication】WillTerminate"];
    [self addTrackInfo:trackString];
}


@end
