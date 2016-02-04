//
//  AnalyticsHelperNetworkProtocol.h
//  DraftControl
//
//  Created by Stephen Lind on 9/30/13.
//  Copyright (c) 2013 Stephen Lind. All rights reserved.
//

#import "AnalyticsHelper.h"

/*
 This protocol enables testing of the Analytics Helper. You can create a production
 NetworkHandler to actually send / receive data, or use a mock handler for testing purposes.
 */

@class AnalyticsEvent;
@protocol AnalyticsNetworkHandler <NSObject>
- (BOOL)sendPayload:(NSData*)payload;
- (NSData*)createEventPayload:(AnalyticsEvent*)analyticsEvent machineIdentifier:(NSString*)machineIdentifier;
- (NSData*)createScreenViewPayload:(NSString*)viewName machineIdentifier:(NSString*)machineIdentifier appVersion:(NSString*)appVersion;
@end

