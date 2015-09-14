//
//  CAEvent.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CAEvent.h"

@implementation CAEvent

-(NSDictionary*)dictionaryRepresentation {
    return @{CACreationDateKey: self.date, CAEventLabelKey: self.label};
}


@end
