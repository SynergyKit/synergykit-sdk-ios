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

#import "SynergykitObject.h"
#import "SPlatform.h"
#import "SAuthData.h"

/**
 *  Base Synergy user from witch every user need to be inherited.
 */
@interface SynergykitUser : SynergykitObject

#pragma mark
#pragma mark Propeties
#pragma mark

/**
 *  E-mail
 */
@property (nonatomic, strong) NSString<Optional> * email;

/**
 *  Password
 */
@property (nonatomic, strong) NSString<Optional> * password;

/**
 *  Activation state
 */
@property (nonatomic, strong) NSNumber<Optional> * isActivated;

/**
 *  List of registered platforms.
 */
@property (nonatomic, strong) NSArray<SPlatform, Optional> * platforms;

/**
 *  Activation hash for activation via url.
 */
@property (nonatomic, strong) NSString<Optional> * activationHash;

/**
 *  Session token for authorization. Token is returned by login method.
 */
@property (nonatomic, strong) NSString<Optional> * sessionToken;

/**
 *  User roles represented by array of strings.
 */
@property (nonatomic, strong) NSArray<Optional> * roles;

/**
 *  Authorization data for user registration view social services.
 */
@property (nonatomic, strong) SAuthData<Optional> * authData;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes object with object._id. After this init you can call @b object.fetch().
 *
 *  @param id        API identificator
 *
 *  @return Instance
 */
-(instancetype) initWithId:(NSString *)_id;

#pragma mark 
#pragma mark Instance methods
#pragma mark 

/**
 *  Activates user account @e synchronous.
 *
 *  @return @c SResponse object
 */
-(SResponse *) activate;

/**
 *  Log in user account @e synchronous.
 *
 *  @return @c SResponse object
 */
-(SResponse *) login;

/**
 *  Activates user account @e asynchronous.
 *
 *  @param handler Callback of function
 */
-(void) activate:(void (^)(SResponse *result))handler;

/**
 *  Log in user account @e asynchronous.
 *
 *  @param handler Callback of function
 */
-(void) login:(void (^)(SResponse *result))handler;

#pragma mark
#pragma mark Roles
#pragma mark

/**
 *  Adds role to user @e asynchronous.
 *
 *  @param role    Role to be added
 *  @param handler SResponse object
 */
-(void) addRole:(NSString *)role handler:(void (^)(SResponse *result))handler;

/**
 *  Adds role to user @e synchronous.
 *
 *  @param role Role to add
 *
 *  @return SResponse object
 */
-(SResponse *) addRole:(NSString *)role;

/**
 *  Removes role from user @e asynchronous.
 *
 *  @param role    Role to remove
 *  @param handler SResponse object
 */
-(void) removeRole:(NSString *)role handler:(void (^)(SResponse *result))handler;

/**
 *  Removes role from user @e synchronous.
 *
 *  @param role Role to remove
 *
 *  @return SResponse object
 */
-(SResponse *) removeRole:(NSString *)role;





@end