//
//  AppDelegate+topViewController.m
//  TestTDD
//
//  Created by gongliang on 2018/7/23.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import "AppDelegate+topViewController.h"

@implementation AppDelegate (topViewController)

+ (nullable UIViewController *)gl_topViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self gl_topViewControllerByRootViewController:rootViewController];
}

+ (nullable NSString *)gl_topViewControllerTitle {
    return [self gl_topViewController].navigationItem.title;
}

+ (nullable NSArray <NSString *>*)gl_topViewControllers {
    return @[];
}

+ (UIViewController *)gl_topViewControllerByRootViewController:(UIViewController *)rootViewController {
    // 视图被 presendted 出来
    if (rootViewController.presentedViewController) {
        return [self gl_topViewControllerByRootViewController:rootViewController.presentedViewController];
    }
    
    // 根视图为 UITabBarController
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedViewController = [(UITabBarController *)rootViewController selectedViewController];
        return [self gl_topViewControllerByRootViewController:selectedViewController];
    }
    // 根视图为 UINavigationController
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visibleViewController = [(UINavigationController *)rootViewController visibleViewController];
        return [self gl_topViewControllerByRootViewController:visibleViewController];
    }
    
    // 根视图为非导航类
    if ([rootViewController respondsToSelector:NSSelectorFromString(@"contentViewController")]) {
        UIViewController *tempViewController = [rootViewController performSelector:@selector(contentViewController)];
        if (tempViewController) {
            return [self gl_topViewControllerByRootViewController:tempViewController];
        }
    }
    return rootViewController;
}

@end
