//
//  AppDelegate.m
//  SimpleCocoaAnalytics
//
//  Created by Stephen Lind on 10/28/13.

#import "AppDelegate.h"
#import "AnalyticsHelper.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    AnalyticsHelper *analyticsHelper = [AnalyticsHelper sharedInstance];
    [analyticsHelper beginPeriodicReportingWithAccount:@"UA-XXXXXXXXX-1"
                                                  name:@"My App"
                                               version:@"0.1"];
    
    
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [AnalyticsHelper.sharedInstance handleApplicationWillClose];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (IBAction)eventButtonClicked:(id)sender {
    [AnalyticsHelper.sharedInstance recordCachedEventWithCategory:@"My Category"
                                                           action:@"My Action"
                                                            label:@"My Label"
                                                            value:@1];
}

@end
