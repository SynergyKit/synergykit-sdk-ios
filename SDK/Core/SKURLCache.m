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

#import "SKURLCache.h"
#import "SKCacheManager.h"

static NSString * const CustomURLCacheExpirationKey = @"CustomURLCacheExpiration";

@implementation SKURLCache

+(instancetype) sharedURLCache
{
    static SKURLCache *_standardURLCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _standardURLCache = [[SKURLCache alloc] initWithMemoryCapacity:(5 * 1024 * 1024) diskCapacity:(100 * 1024 * 1024) diskPath:nil];
    });
    return _standardURLCache;
}

-(NSCachedURLResponse *) cachedResponseForRequest:(NSURLRequest *)request
{
    NSCachedURLResponse *cachedResponse = [super cachedResponseForRequest:request];

    if (cachedResponse && cachedResponse.userInfo[CustomURLCacheExpirationKey])
    {
        if ([(NSDate *)cachedResponse.userInfo[CustomURLCacheExpirationKey] timeIntervalSince1970] <= [[NSDate date] timeIntervalSince1970])
        {
            // Cache expired
            [super removeCachedResponseForRequest:request];
            return nil;
        }
    }
    return cachedResponse;
}
             
- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request
{
    NSMutableDictionary *expirationDict = [[SKCacheManager sharedInstance] expirationDict];
    id expiration = [expirationDict objectForKey:request.URL.absoluteURL];
    
    if (!expiration)
    {
        // Expiration is not set
        [super storeCachedResponse:cachedResponse forRequest:request];
        return;
    }
    
    if (![expiration isKindOfClass:[NSNull class]])
    {
        // Cache now
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:cachedResponse.userInfo];
        userInfo[CustomURLCacheExpirationKey] = [NSDate dateWithTimeInterval:(NSTimeInterval)[expiration doubleValue] sinceDate:[NSDate date]];
        [expirationDict setObject:[NSNull new] forKey:request.URL.absoluteURL];
        
        NSCachedURLResponse *modifiedCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:userInfo storagePolicy:cachedResponse.storagePolicy];
        
        [super storeCachedResponse:modifiedCachedResponse forRequest:request];
    }
}

-(void)removeAllCachedResponses
{
    [super removeAllCachedResponses];
    [[SKCacheManager sharedInstance] setExpirationDict:[NSMutableDictionary new]];
}

@end
