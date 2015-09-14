//
//  CABaseEvent.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CABaseEvent.h"

@implementation CABaseEvent

-(NSDictionary*)dictionaryRepresentation {
    [NSException raise:@"Not implemented!" format:@"this class is abstract"];
    return nil;
}


@end
