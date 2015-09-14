//
//  WKInterfaceController+CrystalAnalytics.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 02/05/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "WKInterfaceController+CrystalAnalytics.h"

@implementation WKInterfaceController (CrystalAnalytics)

//! Track the current InterfaceController on Crystal Analytics, with the view name that you pass into this method
-(void)trackViewWithName:(NSString*)viewName {
    [CrystalAnalytics trackViewWithName:viewName];
}

//! Track the current Glance on Crystal Analytics, with the glance name that you pass into this method
-(void)trackGlanceWithName:(NSString*)glanceName {
    [CrystalAnalytics trackGlanceWithName:glanceName];
}

@end
