SimpleCocoaGoogleAnalytics
==========================

A simple set of classes of using Google Analytics to track your OS X app's usage.

## Usage:

Add these to your app's project:
* AnalyticsHelper.h
* AnalyticsHelper.m
* AnalyticsEvent.h
* AnalyticsEvent.m

Add reporting code to app launch and quit, and on relevant events.

See AppDelegate.m in the example app for how to begin reporting and send events.

If you want to use this project in an application for the Mac App store
remember that there is a policy guideline against data collection: *Apps cannot
transmit data about a user without obtaining the user's prior permission and
providing the user with access to information about how and where the data will
be used*. Your app has to ask the user for permission to collect data or it may
be rejected during the approval process.


## License

This project uses the [MIT License](LICENSE.md).

## Contribution

There are many features of google analytics that I haven't implemented. Pull requests are welcome.

