//
//  CAPurchaseEvent.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CABaseEvent.h"
#import "CAEvent.h"

@interface CAPurchaseEvent : CAEvent <CADictionaryRepresentation>

@property NSNumber *price;

@end
