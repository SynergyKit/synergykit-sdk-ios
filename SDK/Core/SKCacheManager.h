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

#import <Foundation/Foundation.h>
#import "SCache.h"
#import "SKURLCache.h"

@interface SKCacheManager : NSObject

+(id) sharedInstance;

/**
 *  Is there any internet connection?
 */
@property (nonatomic) BOOL isReachable;

/**
 *  Is there wifi connection?
 */
@property (nonatomic) BOOL isWifiConnected;

/**
 *  Contains time interval objects for requests.
 */
@property (nonatomic, strong) NSMutableDictionary *expirationDict;

/**
 *  Cache policy based on internet connection.
 *
 *  @return @b Connected – NSURLRequestUseProtocolCachePolicy;
 *          @b Disconnected – NSURLRequestReturnCacheDataElseLoad
 */
+(NSURLRequestCachePolicy) loadElseCache;

/**
 *  Saves expiration interval for request for usage in SKURLCache.
 *
 *  @param request Request for which expiration interval will be saved.
 *  @param seconds Expiration interval in seconds.
 */
+(void) request:(NSURLRequest *)request expirationInterval:(NSTimeInterval)seconds;

@end
