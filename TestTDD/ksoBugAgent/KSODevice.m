//
//  KSODevice.m
//  TestTDD
//
//  Created by gongliang on 2018/7/24.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import "KSODevice.h"
#import <sys/utsname.h>     // 获取设备类型：eg iPhone10,3
#import <mach-o/arch.h>     // 获取 CPU 的架构类型
#import <UIKit/UIDevice.h>
#import <mach/mach.h>       // 获取 CPU，磁盘信息

@interface KSODevice()

@property (nonatomic, strong) UIDevice *device;

@end

@implementation KSODevice

#pragma mark - Public
- (nonnull NSString *)systemName {
    return self.device.systemName ?: @"";
}

- (nonnull NSString *)systemVersion {
    return self.device.systemVersion ?: @"";
}

- (nonnull NSString *)deviceModel {
    // 获取设备类型：
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine
                                               encoding:NSUTF8StringEncoding];
    return deviceModel ?: @"";
}

- (nonnull NSString *)appVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: @"";
}

#pragma mark - properties
- (UIDevice *)device {
    if (!_device) {
        _device = [UIDevice currentDevice];
    }
    return _device;
}

// 获取 cpu 架构类型
- (NSString *)cpuString {
    const NXArchInfo *info = NXGetLocalArchInfo();
    NSString *cpuString = [NSString stringWithCString:info->description
                                             encoding:NSUTF8StringEncoding];
    return cpuString;
}

#pragma mark - Memory
// 获取总内存大小
- (int64_t)getTotalMemory {
    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];
    if (totalMemory < -1) totalMemory = -1;
    return totalMemory;
}

// 获取使用的内存大小
- (int64_t)getActiveMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.active_count * page_size;
}

// 获取空闲的内存大小
- (int64_t)getFreeMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

#pragma mark - Disk
// 获取剩余的磁盘空间
- (int64_t)getFreeDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

@end
