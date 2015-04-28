//
//  Synergykit SDK iOS
//  Created by Jan Cislinsky.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Letsgood.com s.r.o.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//

#import "SKCacheManager.h"
#import "SKSynergy.h"
#import "Reachability.h"

@interface SKCacheManager ()

@property (nonatomic, strong) Reachability * reachability;

@end

@implementation SKCacheManager

// #############################################################################
#pragma mark - [PRIVATE] Instance handling

-(id) init
{
    self = [super init];
    if (self)
    {
        [self setReachability:[Reachability reachabilityForInternetConnection]];
        [self setExpirationDict:[[NSMutableDictionary alloc] init]];
    }
    return self;
}

// #############################################################################
#pragma mark - [PUBLIC]

-(BOOL)isReachable
{
    return [_reachability currentReachabilityStatus] != NotReachable;
}

-(BOOL)isWifiConnected
{
    return [_reachability currentReachabilityStatus] == ReachableViaWiFi;
}

// #############################################################################
#pragma mark - [STATIC]

+(id) sharedInstance
{
    static dispatch_once_t once;
    static SKCacheManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+(NSURLRequestCachePolicy) loadElseCache
{
    return [[SKCacheManager sharedInstance] isReachable] ? NSURLRequestUseProtocolCachePolicy : NSURLRequestReturnCacheDataElseLoad;
}

+(void) request:(NSURLRequest *)request expirationInterval:(NSTimeInterval)seconds
{
    if (seconds <= 0) return;
    
    SKCacheManager *manager = [SKCacheManager sharedInstance];
    NSNumber *expirationInterval = [NSNumber numberWithDouble:seconds];
    
    if (request) [manager.expirationDict setObject:expirationInterval forKey:request.URL.absoluteURL];
}

@end
