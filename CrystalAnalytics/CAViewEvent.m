//
//  CAViewEvent.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CAViewEvent.h"

@implementation CAViewEvent

-(NSDictionary*)dictionaryRepresentation {
    return @{CACreationDateKey: self.date, CAViewNameKey: self.title};
}

@end
