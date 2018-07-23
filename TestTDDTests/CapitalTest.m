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
    
    self.viewController = [ViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMakeHeadlineReturnsStringWithEachWordStartCapital {
    
    NSString *inputString = @"Here is another Example";
    NSString *expectedHeadline = @"Here Is Another Example";
    
    NSString *resultHeadline = [self.viewController makeHeadline:inputString];
    
    XCTAssertTrue([resultHeadline isEqualToString:expectedHeadline]);
}


@end
