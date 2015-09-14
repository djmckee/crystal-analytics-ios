//
//  CACrystal.m
//  CrystalAnalytics
//
//  Created by Dylan McKee on 30/04/2015.
//  Copyright (c) 2015 CrystalAnalytics. All rights reserved.
//

#import "CrystalAnalytics.h"

// Networking.
#import "CANetworkConstants.h"
#import "CANetworkHandler.h"
#import "CANetworkEndpoints.h"

// Data model.
#import "CASession.h"
#import "CAEvent.h"
#import "CAPurchaseEvent.h"
#import "CAViewEvent.h"
#import "CAScreenView.h"
#import "CAGlanceView.h"
#import "CADictionaryKeys.h"

// some constants...
NSString * const SessionIdPersistanceKey = @"CrystalAnalyticsSessionIdKey";

// private methods/properties.
@interface CrystalAnalytics()

+(instancetype)sharedManager;

@property NSString *appId;
@property NSString *sessionId;

@end

@implementation CrystalAnalytics

+(instancetype)sharedManager {
    static CrystalAnalytics *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    if (self = [super init]) {
        // initial setup code goes here.
        // and attempt to send failed events.
        [self attemptToSendPreviousFailedEvents];
    }
    return self;
}

-(void)attemptToSendPreviousFailedEvents {
    // loop through persisted events that've failed to send, and try sending them (maybes the user now has internet connection or w/e)
    NSArray *eventsToSend = [[NSUserDefaults standardUserDefaults] arrayForKey:CARequestQueueId];
    if (!eventsToSend) {
        // nothing. give up.
        return;
    }
    
    // reset saved array before beginning sending attempt...
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CARequestQueueId];
    
    // if the app crashes *now* we're screwed.
    
    for (NSDictionary *dict in eventsToSend) {
        NSString *endpoint = [dict objectForKey:@"endpoint"];
        NSDictionary *data = [dict objectForKey:@"data"];
        
        [self sendDictionary:data toEndpoint:endpoint];
    }
    
}

-(void)sendDictionary:(NSDictionary*)dict toEndpoint:(NSString *)endpoint {
    // send!!!!!!!1
    CANetworkHandler *connection = [[CANetworkHandler alloc] init];
    [connection sendDictionary:dict toEndpoint:endpoint];
}

+(NSString*)watchSizeString {
    WKInterfaceDevice *device = [WKInterfaceDevice currentDevice];
    
    CGRect screenFrame = [device screenBounds];
    
    if (CGSizeEqualToSize(screenFrame.size, CGSizeMake(272.0, 340.0))) {
        return @"38mm";
    }
    
    if (CGSizeEqualToSize(screenFrame.size, CGSizeMake(312.0, 390.0))) {
        return @"42mm";
    }
    
    return @"Unknown";
    
}

+(void)sendObject:(id <CADictionaryRepresentation>)object toEndpoint:(NSString *)endpoint {
    // if App ID or Session ID is nil, do not continue.
    if (![[self sharedManager] sessionId] || ![[self sharedManager] appId]) {
        return;
    }
    
    // get a dictionary representation, make it mutable, add keys for app ID and Session ID
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[object dictionaryRepresentation]];
    
    // set App ID
    [dict setObject:[[self sharedManager] appId] forKey:CAAppIDKey];
    
    // set session ID
    [dict setObject:[[self sharedManager] sessionId] forKey:CASessionIDKey];
    
    // now send...
    [[self sharedManager] sendDictionary:dict toEndpoint:endpoint];
}

+(void)startWithAppId:(NSString*)appIdString {
    // begin singleton for this session, setting up app ID string too.
    [[self sharedManager] setAppId:appIdString];
    
    // check NSUserDefaults for persisted session information?
    // if no session ID exists, generate a new one.
    NSString *savedSessionId = [[NSUserDefaults standardUserDefaults] stringForKey:SessionIdPersistanceKey];
    if (!savedSessionId) {
        // generate new session ID
        NSUUID *newSessionId = [NSUUID UUID];
        
        NSString *newSessionIdString = [newSessionId UUIDString];
        
        [[NSUserDefaults standardUserDefaults] setObject:newSessionIdString forKey:SessionIdPersistanceKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // a new session has been created - let's instanciate a model for it and send to server...
        CASession *session = [[CASession alloc] init];
        session.sessionId = newSessionIdString;
        session.creationDate = [NSDate date];
        session.deviceSize = [self watchSizeString];
        
        // send to server...
        [self sendObject:session toEndpoint:CASessionEndpoint];
        
    } else {
        // existing session ID exists... set instance variable...
        [[self sharedManager] setSessionId:savedSessionId];
    }
    
}

+(void)trackViewWithName:(NSString*)viewName {
    // if there's no name, give up.
    if (!viewName) {
        return;
    }
    
    CAScreenView *view = [[CAScreenView alloc] init];
    view.date = [NSDate date];
    view.title = viewName;
    
    // send to server.
    [self sendObject:view toEndpoint:CAViewEndpoint];

}

+(void)trackGlanceWithName:(NSString*)glanceName {
    if (!glanceName) {
        return;
    }
    
    CAGlanceView *glance = [[CAGlanceView alloc] init];
    glance.date = [NSDate date];
    glance.title = glanceName;
    
    // send to server.
    [self sendObject:glance toEndpoint:CAGlanceEndpoint];

}

+(void)trackEventWithName:(NSString*)eventName {
    if (!eventName) {
        return;
    }
    
    CAEvent *event = [[CAEvent alloc] init];
    event.date = [NSDate date];
    event.label = eventName;
    
    // send to serverer.
    [self sendObject:event toEndpoint:CAEventEndpoint];

    
}

+(void)trackPurchaseWithName:(NSString*)purchaseName andValue:(double)value {
    if (!purchaseName) {
        return;
    }
    
    CAPurchaseEvent *purchase = [[CAPurchaseEvent alloc] init];
    purchase.date = [NSDate date];
    purchase.label = purchaseName;
    purchase.price = [NSNumber numberWithDouble:value];
    
    // send.
    [self sendObject:purchase toEndpoint:CAPurchaseEndpoint];

}


@end
