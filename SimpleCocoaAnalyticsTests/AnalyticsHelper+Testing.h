//
//  AnalyticsHelper+Testing.h
//  DraftControl
//
//  Created by Stephen Lind on 9/30/13.
//  Copyright (c) 2013 Stephen Lind. All rights reserved.
//

#import "AnalyticsHelper.h"
#import "AnalyticsHelperNetworkProtocol.h"

@interface AnalyticsHelper (Testing)

- (NSArray*)recordedEvents;
- (void)clearRecordedEvents;

- (NSUInteger)getErrorCount;
- (void)clearErrors;
- (void)recordSendError;
- (void)sendReport;
- (void)saveCachedEventsToDisk;
- (void)createAndSendReport:(id)sender;
- (void)testSetNetworkHandler:(id<AnalyticsNetworkHandler>)handler;
@end
