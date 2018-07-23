//
//  CapitalTest.m
//  TestTDDTests
//
//  Created by gongliang on 2018/7/23.
//  Copyright © 2018年 gongliang. All rights reserved.
//

/*
 TDD的优缺点
 我们体验了TDD的开发流程，它在保证开发质量方面，很有吸引力。但它也是一种有别于传统开发流程的开发方法，有优点，也有缺点。
 
 优点
 
 产出的都是需要的代码：遵循TDD的规则，当所有测试通过时，你必须停止编写生产代码。由于你写的代码都是以最简单的形式让测试通过的代码。所以，最终产品中的所有代码实际上都是实现这些功能所需要的代码。
 
 更模块化的设计：在TDD中，你一次只集中一个小功能。而当你先编写测试时，代码会自动变得容易测试。易于测试的代码具有清晰的接口。这将为你的应用程序带来更模块化的设计。
 
 更易于维护：由于应用程序的各个部分彼此解耦，并且具有清晰的接口，代码变得更易于维护。你可以在不影响其他模块的情况下为功能更换一个更好的实现。
 
 更易于重构：所有功能都已经经过彻底地测试。你不用害怕做出巨大的修改，因为如果所有测试仍然通过，那么一切都安好。
 
 高测试覆盖率：每个功能都有测试，这会带来高测试覆盖率，让你对自己的代码更有信心。
 
 测试既是代码的文档：测试代码展示了你的代码是如何使用的。因此它相当于是你的代码的文档和示例代码，展示了代码的作用以及如何使用接口。
 
 更少的调试：你每天浪费了多少时间在调试找Bug上？使用TDD，在编写测试时可以提前发现错误，更不容易产出Bug。
 
 缺点
 
 没有银弹：测试有助于发现错误，但它们不能发现你在测试代码和实现代码中引入的bug。如果你没有明白你需要解决的问题是什么，那么编写测试也没有多大帮助。
 
 开始看起来比较慢：如果你刚开始TDD，你会觉得需要更长的时间才能完成一个简单的实现。你需要先考虑接口设计，编写测试代码并运行测试，最后才能开始编写实现代码。
 
 团队中所有成员都需要做TDD：由于TDD影响代码的设计，因此建议团队中的所有成员都使用TDD或者都不使用。除此之外，有时很难向管理层证明TDD。因为他们经常会觉得，如果开发人员花一半的时间来编写最终并不会存在于产品中的代码(测试代码)，那么新功能的实现将会需要更长的时间。所以，如果整个团队都认同单元测试的重要性，这才有所帮助。
 
 需求变化时需要维护测试用例：也许对TDD最强烈的争论就是测试与代码一样必须进行维护。无论什么时候需求变化了，你都需要修改代码和测试。但是你使用的是TDD，这意味着你需要先更改测试，然后再通过测试。因此，实际上，这个缺点和前一个一样，显然需要花费更长时间。
 */

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


/**
 红1. 这个测试方法没有写完，因为我们还没有写断言，没有测试任何东西。但是我们不得不暂停。因为现在编译器已经报错，说我们的 ViewController declares the selector 'makeHeadline', 根据 TDD 流程，我们需要添加代码，知道编译器不再报错。测试代码编译不通过，也意味着“测试失败”。测试失败意味着我们需要编写代码。
 绿2. 编写简单的代码使测试通过，当然这段代码使错误的而且很愚蠢
 */
- (void)testMakeHeadlineReturnsStringWithEachWordStartCapital {
    
    NSString *inputString = @"Here is example";
    NSString *expectString = @"Here Is Example";

    NSString *resultString = [self.viewController makeHeadline:inputString];
    XCTAssertTrue([resultString isEqualToString:expectString]);
}


@end
