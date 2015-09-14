//
//  WKInterfaceController+CrystalAnalytics.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 02/05/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import <CrystalAnalytics/CrystalAnalytics.h>
#import <WatchKit/WatchKit.h>

@interface WKInterfaceController (CrystalAnalytics)

//! Track the current InterfaceController on Crystal Analytics, with the view name that you pass into this method
-(void)trackViewWithName:(NSString*)viewName;

//! Track the current Glance on Crystal Analytics, with the glance name that you pass into this method
-(void)trackGlanceWithName:(NSString*)glanceName;

@end
