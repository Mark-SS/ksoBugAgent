//
//  KSODevice.h
//  TestTDD
//
//  Created by gongliang on 2018/7/24.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSODevice : NSObject

// 获取当前系统名 eg: iOS
- (NSString *)systemName;

// 获取当前系统版本 eg: 11.4
- (NSString *)systemVersion;

// 获取设备 model, eg: iPhone8,1
- (NSString *)deviceModel;

// 获取 app 的版本, eg: 1.1
- (NSString *)appVersion;

// 获取可用内存大小，单位 Byte，
- (int64_t)getFreeMemory;

// 获取剩余的磁盘空间，单位 Byte
- (int64_t)getFreeDiskSpace;
@end
