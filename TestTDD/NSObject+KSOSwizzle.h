//
//  NSObject+KSOSwizzle.h
//  TestTDD
//
//  Created by gongliang on 2018/7/24.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KSOSwizzle)

+ (void)kso_swizzleSEL:(SEL)originalSEL
               withSEL:(SEL)swizzledSEL;

@end
