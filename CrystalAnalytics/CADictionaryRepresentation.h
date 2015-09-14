//
//  CAJsonRepresentation.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 01/05/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CADictionaryKeys.h"

@protocol CADictionaryRepresentation <NSObject>

-(NSDictionary*)dictionaryRepresentation;

@end
