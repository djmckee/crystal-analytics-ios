//
//  CASession.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CASession.h"

@implementation CASession

-(NSDictionary*)dictionaryRepresentation {
    return @{CASessionIDKey: self.sessionId, CACreationDateKey: self.creationDate, CADeviceSizeKey: self.deviceSize};
}

@end
