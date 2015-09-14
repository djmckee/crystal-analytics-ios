//
//  CAPurchaseEvent.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CAPurchaseEvent.h"

@implementation CAPurchaseEvent

-(NSDictionary*)dictionaryRepresentation {
    return @{CAEventLabelKey: self.label, CAPurchaseValueKey: self.price};
}

@end
