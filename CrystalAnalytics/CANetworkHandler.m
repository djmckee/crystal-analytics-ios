//
//  CANetworkManager.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CANetworkHandler.h"
#import "CANetworkConstants.h"

NSString *const ThreadId = @"io.crystalanalytics.Task";

#define NETWORK_LOGGING 1

@implementation CANetworkHandler

-(void)sendDictionary:(NSDictionary*)dict toEndpoint:(NSString*)endpoint {
    // convert dict to JSON String
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:ThreadId];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", CABaseUrl, endpoint];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:CAClientId          forHTTPHeaderField:@"User-Agent"];
    [request setHTTPMethod:@"POST"];
    

    NSError *error;

    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    
    if (error) {
        // something's gone horribly wrong - quit whilst we're ahead...
        return;
    }
    
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (NETWORK_LOGGING) {
            if (error) {
                NSLog(@"CrystalAnalytics - sending error: %@", error);
            } else {
                NSLog(@"CrystalAnalytics - sending success: %@", dict);
            }
        }
        
        if (error) {
            // persist dict and endpoint so we can retry sending next time...
            NSDictionary *saveDict = @{@"endpoint": endpoint, @"data": dict};
            
            // add on the main thread...
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *existing = [[NSUserDefaults standardUserDefaults] arrayForKey:CARequestQueueId];
                NSMutableArray *mutable;
                if (!existing) {
                    mutable = [NSMutableArray arrayWithObject:saveDict];
                } else {
                    mutable = [NSMutableArray arrayWithArray:existing];
                    [mutable addObject:saveDict];
                }
                
                NSArray *newValue = [NSArray arrayWithArray:existing];
                
                [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:CARequestQueueId];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            });
        }
        
        // otherwise, do nothing.
    }];
    
    // do the request.
    [postDataTask resume];
    
}

@end
