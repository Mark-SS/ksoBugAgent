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

- (void)kso_bugAgent_viewWillAppear:(BOOL)animated {
    [self kso_bugAgent_viewWillAppear:animated];
    [[KSOBugAgent sharedInstance] trackViewWillAppear:self];
}

@end
