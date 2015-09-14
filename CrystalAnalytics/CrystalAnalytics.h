//
//  CACrystal.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
#import <CrystalAnalytics/WKInterfaceController+CrystalAnalytics.h>

/*
 
 To use within your project, simply #import <CrystalAnalytics/CrystalAnalytics.h>
 (or, if you're using Swift, add that to your Project Bridging Header).
 
*/

//! Project version number for CrystalAnalytics.
FOUNDATION_EXPORT double CrystalAnalyticsVersionNumber;

//! Project version string for CrystalAnalytics.
FOUNDATION_EXPORT const unsigned char CrystalAnalyticsVersionString[];

@interface CrystalAnalytics : NSObject

//! Start tracking this extension/glance with the app ID (obtained from crystalanalytics.io)
+(void)startWithAppId:(NSString*)appIdString;

//! Track the current interface controller, with a desired name
+(void)trackViewWithName:(NSString*)viewName;

//! Track the current glance controller, with a desired name
+(void)trackGlanceWithName:(NSString*)glanceName;

//! Track an event, with a unique name label
+(void)trackEventWithName:(NSString*)eventName;

//! Track a purchase event, with a unique name label and value
+(void)trackPurchaseWithName:(NSString*)purchaseName andValue:(double)value;


@end
