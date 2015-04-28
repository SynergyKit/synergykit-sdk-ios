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

#import "JSONModel.h"

@class SAuthDataFacebook;
@class SAuthDataTwitter;
@class SAuthDataGoogle;

#pragma mark
#pragma mark AuthData
#pragma mark

@interface SAuthData : JSONModel

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Facebook authorization data
 */
@property (nonatomic, strong) SAuthDataFacebook<Optional>* facebook;

/**
 *  Twitter authorization data
 */
@property (nonatomic, strong) SAuthDataTwitter<Optional>* twitter;

/**
 *  Google authorization data
 */
@property (nonatomic, strong) SAuthDataGoogle<Optional>* google;

#pragma mark
#pragma mark Initialization
#pragma mark

-(instancetype) initWithFacebook:(SAuthDataFacebook*)facebookData;

-(instancetype) initWithTwitter:(SAuthDataTwitter*)twitterData;

-(instancetype) initWithGoogle:(SAuthDataGoogle*)googleData;

@end

#pragma mark
#pragma mark Facebook
#pragma mark

@interface SAuthDataFacebook : JSONModel

@property (nonatomic, strong) NSString* _id;
@property (nonatomic, strong) NSString<Optional>* accessToken;

-(instancetype) initWithId:(NSString *)_id accessToken:(NSString *)accessToken;

@end

#pragma mark
#pragma mark Twitter
#pragma mark

@interface SAuthDataTwitter : JSONModel

@property (nonatomic, strong) NSString* _id;
@property (nonatomic, strong) NSString* screenName;
@property (nonatomic, strong) NSString* consumerKey;
@property (nonatomic, strong) NSString* consumerSecret;
@property (nonatomic, strong) NSString* authToken;
@property (nonatomic, strong) NSString* authTokenSecret;

-(instancetype) initWithId:(NSString *)_id screenName:(NSString *)screenName consumerKey:(NSString*)consumerKey consumerSecret:(NSString *)consumerSecret authToken:(NSString *)authToken authTokenSecret:(NSString *)authTokenSecret;

@end

#pragma mark
#pragma mark Google
#pragma mark

@interface SAuthDataGoogle : JSONModel

@property (nonatomic, strong) NSString* _id;
@property (nonatomic, strong) NSString<Optional>* clientId;
@property (nonatomic, strong) NSString<Optional>* accessToken;
@property (nonatomic, strong) NSString<Optional>* tokenType;
@property (nonatomic, strong) NSString<Optional>* refreshToken;
@property (nonatomic, strong) NSNumber<Optional>* expirationDate;

-(instancetype) initWithId:(NSString *)_id clientId:(NSString *)clientId accessToken:(NSString *)accessToken tokenType:(NSString *)tokenType refreshToken:(NSString *)refreshToken expirationDate:(NSNumber *)expirationDate;

@end