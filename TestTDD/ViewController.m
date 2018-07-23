//
//  ViewController.m
//  TestTDD
//
//  Created by gongliang on 2018/7/20.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSString *)makeHeadline:(NSString *)string {
    NSArray *words = [string componentsSeparatedByString:@" "];
    NSMutableArray *mutableWords = [[NSMutableArray alloc] initWithCapacity:words.count];
    [words enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *firstChar = [obj substringToIndex:1];
        NSString *uppercaseString = [firstChar uppercaseString];
        NSString *string2 = [obj stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                                         withString:uppercaseString];
        [mutableWords addObject:string2];
    }];
    return [mutableWords componentsJoinedByString:@" "];
}

@end
