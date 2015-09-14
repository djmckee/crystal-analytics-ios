//
//  CABaseEvent.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CADictionaryRepresentation.h"

@interface CABaseEvent : NSObject <CADictionaryRepresentation>

@property NSDate *date;

@end
