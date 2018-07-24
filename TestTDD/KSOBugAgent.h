//
//  KSOBugAgent.h
//  TestTDD
//
//  Created by gongliang on 2018/7/24.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewController.h>

@interface KSOBugAgent : NSObject


/**
 开启 Bug 追踪
 */
+ (void)start;

+ (instancetype)sharedInstance;
/**
 追中 viewController

 @param viewController UIViewController
 */
- (void)trackViewWillAppear:(UIViewController *)viewController;

@end
