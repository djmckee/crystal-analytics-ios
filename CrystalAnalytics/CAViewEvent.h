//
//  CAViewEvent.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CABaseEvent.h"

@interface CAViewEvent : CABaseEvent <CADictionaryRepresentation>

@property NSString *title;

@end
