//
//  TestTDDTests.m
//  TestTDDTests
//
//  Created by gongliang on 2018/7/20.
//  Copyright © 2018年 gongliang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TestTDDTests : XCTestCase

@end

@implementation TestTDDTests

// 每个测试用例调用前，都会先调用 setUp 方法，
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

// 每个测试用例执行结束后，都会调用 tearDown 方法，大体流程就是：setUp - test case - tearDown - setUp - test case - tearDown... 所以我们一般在 setUp 中做一些初始化操作，在 tearDown 做一些清楚释放操作
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
