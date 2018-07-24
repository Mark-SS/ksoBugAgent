//
//  BViewController.m
//  TestTDD
//
//  Created by gongliang on 2018/7/23.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 数组越界
- (IBAction)arrayCrash1:(UIButton *)sender {
    NSArray *a = @[];
    NSLog(@"secondObject: %@", a[1]);
}

#pragma mark - 数组插入 nil
- (IBAction)arrayCrash2:(UIButton *)sender {
    NSMutableArray *a = [NSMutableArray array];
    NSString *testString = nil;
    [a addObject:testString];
}

- (IBAction)dictionaryCrash1:(UIButton *)sender {
    NSString *testString = nil;
    NSDictionary *dict = @{@"test": testString};
    NSLog(@"dict: %@", dict);
}

#pragma mark - 字典插入 nil

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
