//
//  DiazNayely_R3_U2UITestsLaunchTests.m
//  DiazNayely-R3-U2UITests
//
//  Created by Ismael Sánchez Rios on 11/12/23.
//

#import <XCTest/XCTest.h>

@interface DiazNayely_R3_U2UITestsLaunchTests : XCTestCase

@end

@implementation DiazNayely_R3_U2UITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
