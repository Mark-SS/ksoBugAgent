//
//  CapitalTest.m
//  TestTDDTests
//
//  Created by gongliang on 2018/7/23.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface CapitalTest : XCTestCase

@property (nonatomic, strong, nonnull) ViewController *viewController;

@end

@implementation CapitalTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


/**
 1. 这个测试方法没有写完，因为我们还没有写断言，没有测试任何东西。但是我们不得不暂停。因为现在编译器已经报错，说我们的 ViewController declares the selector 'makeHeadline', 根据 TDD 流程，我们需要添加代码，知道编译器不再报错。测试代码编译不通过，也意味着“测试失败”。测试失败意味着我们需要编写代码。
 */
- (void)testMakeHeadlineReturnsStringWithEachWordStartCapital {
    ViewController *viewController = [ViewController new];
    
    NSString *string = @"Here is example";
    
    NSString *headline = [viewController makeHeadline];
}


@end
