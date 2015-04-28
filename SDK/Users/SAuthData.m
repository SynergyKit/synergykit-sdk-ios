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

#import "SAuthData.h"

@implementation SAuthData

-(instancetype)initWithFacebook:(SAuthDataFacebook *)facebookData
{
    self = [super init];
    if (self)
    {
        [self setFacebook:facebookData];
    }
    return self;
}

-(instancetype)initWithTwitter:(SAuthDataTwitter *)twitterData
{
    self = [super init];
    if (self)
    {
        [self setTwitter:twitterData];
    }
    return self;
}

-(instancetype)initWithGoogle:(SAuthDataGoogle *)googleData
{
    self = [super init];
    if (self)
    {
        [self setGoogle:googleData];
    }
    return self;
}

@end

#pragma mark
#pragma mark Facebook
#pragma mark

@implementation SAuthDataFacebook

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"_id"}];
}

-(instancetype) initWithId:(NSString *)_id accessToken:(NSString *)accessToken
{
    self = [super init];
    if (self)
    {
        [self set_id:_id];
        [self setAccessToken:accessToken];
    }
    return self;
}

@end

#pragma mark
#pragma mark Twitter
#pragma mark

@implementation SAuthDataTwitter

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"_id"}];
}

-(instancetype) initWithId:(NSString *)_id screenName:(NSString *)screenName consumerKey:(NSString*)consumerKey consumerSecret:(NSString *)consumerSecret authToken:(NSString *)authToken authTokenSecret:(NSString *)authTokenSecret
{
    self = [super init];
    if (self)
    {
        [self set_id:_id];
        [self setScreenName:screenName];
        [self setConsumerKey:consumerKey];
        [self setConsumerSecret:consumerSecret];
        [self setAuthToken:authToken];
        [self setAuthTokenSecret:authTokenSecret];
    }
    return self;
}

@end

#pragma mark
#pragma mark Google
#pragma mark

@implementation SAuthDataGoogle

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"_id"}];
}

-(instancetype) initWithId:(NSString *)_id clientId:(NSString *)clientId accessToken:(NSString *)accessToken tokenType:(NSString *)tokenType refreshToken:(NSString *)refreshToken expirationDate:(NSNumber *)expirationDate
{
    self = [super init];
    if (self)
    {
        [self set_id:_id];
//        [self setClientId:clientId];
//        [self setAccessToken:accessToken];
//        [self setTokenType:tokenType];
//        [self setRefreshToken:refreshToken];
//        [self setExpirationDate:expirationDate];
    }
    return self;
}

@end
