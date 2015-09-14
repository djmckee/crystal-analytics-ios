//
//  CANetworkManager.h
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CANetworkHandler : NSObject

-(void)sendDictionary:(NSDictionary*)dict toEndpoint:(NSString*)endpoint;

@end
