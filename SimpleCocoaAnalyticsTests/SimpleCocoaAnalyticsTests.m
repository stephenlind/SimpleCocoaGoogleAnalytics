//
//  SimpleCocoaAnalyticsTests.m
//  SimpleCocoaAnalyticsTests
//
//  Created by Stephen Lind on 10/28/13.
//  Copyright (c) 2013 foxnsox. All rights reserved.

#import <XCTest/XCTest.h>

#import "AnalyticsEvent.h"
#import "AnalyticsHelper.h"
#import "AnalyticsHelper+Testing.h"
#import "AnalyticsHelperNetworkProtocol.h"


/*!
 TestingNetworkHandler
 Rather than sending test payloads to an actual server, just pretend we did and
 record success or failure, depending on what we want to simulate.
 */
@interface TestingNetworkHandler : NSObject<AnalyticsNetworkHandler>
- (BOOL)sendPayload:(NSData *)payload;
- (NSData*)createEventPayload:(AnalyticsEvent*)analyticsEvent machineIdentifier:(NSString*)machineIdentifier;
- (NSData*)createScreenViewPayload:(NSString*)viewName machineIdentifier:(NSString*)machineIdentifier appVersion:(NSString *)appVersion;

@property NSUInteger sentPayloadCount;
@property BOOL returnSuccess;

@end


@interface SimpleCocoaAnalyticsTests : XCTestCase
@property (strong) TestingNetworkHandler *testingNetworkHandler;
@end


@implementation SimpleCocoaAnalyticsTests

- (void)setUp
{
    [super setUp];
    AnalyticsHelper *helper = AnalyticsHelper.sharedInstance;
    [helper saveCachedEventsToDisk];
    [helper clearErrors];
    [helper clearRecordedEvents];
    
    _testingNetworkHandler = [[TestingNetworkHandler alloc] init];
    [helper testSetNetworkHandler:_testingNetworkHandler];
    self.testingNetworkHandler.sentPayloadCount = 0;
    self.testingNetworkHandler.returnSuccess = NO;
}

- (void)tearDown
{
    // Put teardown code here.
    [super tearDown];
}

/*!
 @brief record some events, make sure they appear in the analytics helper's queue
 */
- (void)testRecordEvents
{
    AnalyticsHelper *helper = AnalyticsHelper.sharedInstance;
    
    NSArray *recordedEvents = [helper recordedEvents];
    XCTAssertTrue([recordedEvents count] == 0, @"There should not be any events");
    
    [helper recordCachedEventWithCategory:@"Event" action:@"Action" label:@"Label" value:@3];
    [helper recordCachedEventWithCategory:@"Event" action:@"Action" label:@"Label" value:@3];
    [helper recordCachedEventWithCategory:@"Event" action:@"Action" label:@"Label" value:@3];
    [helper handleApplicationWillClose];
    
    recordedEvents = [helper recordedEvents];
    NSMutableArray *eventsMinusLaunchEvent = [recordedEvents mutableCopy];
    [eventsMinusLaunchEvent removeLastObject];
    
    XCTAssertTrue([eventsMinusLaunchEvent count] == 3, @"there should be 3 events, found %lu", [recordedEvents count]);
    for (AnalyticsEvent *event in eventsMinusLaunchEvent) {
        XCTAssertTrue([event.category isEqualToString:@"Event"], @"recorded event has the wrong category");
        XCTAssertTrue([event.action isEqualToString:@"Action"], @"recorded event has the wrong action");
        XCTAssertTrue([event.label isEqualToString:@"Label"], @"recorded event has the wrong label");
    }
    
    [helper clearRecordedEvents];
    recordedEvents = [helper recordedEvents];
    XCTAssertTrue([recordedEvents count] == 0, @"There should not be any events");
}

/*!
 @brief Attempt to 'send' some payloads to our testing handler, which should return failure. Errors should then be recorded by the AnalyticsHelper
 */
- (void)testErrorIncrements {
    AnalyticsHelper *helper = AnalyticsHelper.sharedInstance;
    
    NSUInteger errorCount = [helper getErrorCount];
    XCTAssertTrue(errorCount == 0, @"There should be no errors, found %lu", errorCount);
    
    [helper recordSendError];
    errorCount = [helper getErrorCount];
    XCTAssertTrue(errorCount == 1, @"There should be 1 error, found %lu", errorCount);
    
    [helper clearErrors];
    errorCount = [helper getErrorCount];
    XCTAssertTrue(errorCount == 0, @"There should be no errors, found %lu", errorCount);
    
    const NSUInteger expErrors = 100;
    for (int i=0; i<expErrors; i++) {
        [helper recordSendError];
    }
    
    errorCount = [helper getErrorCount];
    XCTAssertTrue(errorCount == expErrors, @"There were %lu errors, expected %lu", errorCount, expErrors);
    
    [helper clearErrors];
    errorCount = [helper getErrorCount];
    XCTAssertTrue(errorCount == 0, @"There should be no errors, found %lu", errorCount);
}

@end


@implementation TestingNetworkHandler

- (BOOL)sendPayload:(NSData *)payload {
    self.sentPayloadCount++;
    return self.returnSuccess;
}

- (NSData*)createEventPayload:(AnalyticsEvent*)analyticsEvent machineIdentifier:(NSString*)machineIdentifier {
    return nil;
}
- (NSData*)createScreenViewPayload:(NSString*)viewName machineIdentifier:(NSString*)machineIdentifier appVersion:(NSString *)appVersion {
    return nil;
}



@end
