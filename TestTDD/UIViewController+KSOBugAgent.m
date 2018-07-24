//
//  UIViewController+KSOBugAgent.m
//  TestTDD
//
//  Created by gongliang on 2018/7/24.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import "UIViewController+KSOBugAgent.h"
#import "NSObject+KSOSwizzle.h"
#import "KSOBugAgent.h"

@implementation UIViewController (KSOBugAgent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self kso_swizzleSEL:@selector(viewWillAppear:)
                     withSEL:@selector(kso_bugAgent_viewWillAppear:)];
    });
}

- (void)kso_bugAgent_viewWillAppear:(BOOL)animated {
    [self kso_bugAgent_viewWillAppear:animated];
    [[KSOBugAgent sharedInstance] trackViewWillAppear:self];
}

@end
