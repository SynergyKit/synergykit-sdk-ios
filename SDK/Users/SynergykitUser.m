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

#import "SynergykitUser.h"
#import "SKSynergy.h"

@implementation SynergykitUser

@synthesize email;
@synthesize endpoint = _endpoint;
@synthesize _id;

-(void)setEmail:(NSString<Optional> *)e
{
    email = [e lowercaseString];
}

#pragma mark
#pragma mark Initialization
#pragma mark

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _endpoint = @"/users";
    }
    return self;
}

-(instancetype) initWithId:(NSString *)n_id
{
    self = [self init];
    if (self)
    {
        [self set_id:n_id];
    }
    return self;
}

#pragma mark
#pragma mark Instance methods
#pragma mark

-(SResponse *) activate
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit activateUserWithHash:self.activationHash completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(SResponse *) login
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit loginUser:self userType:self.class completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void) activate:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit activateUserWithHash:self.activationHash completion:handler async:YES];
}


-(void) login:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit loginUser:self userType:self.class completion:handler async:YES];
}

#pragma mark
#pragma mark SynergykitProtocol & SBatchableProtocol
#pragma mark

-(void)save:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    if (self._id)
    {
        // Update
        [skit updateUser:self completion:handler async:YES];
    }
    else
    {
        // Create
        [skit createUser:self completion:handler async:YES];
    }
}

-(SResponse *)save
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    if (self._id)
    {
        // Update
        [skit updateUser:self completion:^(SResponse *result) {
            response = result;
        } async:NO];
    }
    else
    {
        // Created
        [skit createUser:self completion:^(SResponse *result) {
            response = result;
        } async:NO];
    }
    
    return response;
}

-(SBatchItemWrapper *)saveInBatch:(void (^)(SResponse *))handler
{
    if (![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"Tenant is nil."];
        return nil;
    }
    
    SBatchItem *item;
    if (self._id)
    {
        // Update
        NSString *batchEndpoint = [NSString stringWithFormat:@"/users/%@", self._id];
        item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypePUT endpoint:batchEndpoint body:self];
    }
    else
    {
        // Create
        NSString *batchEndpoint = @"/users";
        item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypePOST endpoint:batchEndpoint body:self];
    }
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(void)fetch:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit user:self completion:handler async:YES];
}

-(SResponse *)fetch
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit user:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(SBatchItemWrapper *)fetchInBatch:(void (^)(SResponse *))handler
{
    if (!self._id || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"_id or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/users/%@", self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeGET endpoint:batchEndpoint body:self];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(void)destroy:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit deleteUserWithId:self._id completion:handler async:YES];
}

-(SResponse *)destroy
{
    __block SResponse *response = nil;
    
    [[SKSynergy sharedInstance] deleteUserWithId:self._id completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(SBatchItemWrapper *)destroyInBatch:(void (^)(SResponse *))handler
{
    if (!self._id || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"_id or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/users/%@", self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeDELETE endpoint:batchEndpoint body:nil];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:nil handler:handler];
    return wrapper;
}

#pragma mark
#pragma mark Roles
#pragma mark

-(void) addRole:(NSString *)role handler:(void (^)(SResponse *result))handler
{
    [[SKSynergy sharedInstance] addRole:role user:self completion:handler async:YES];
}

-(SResponse *) addRole:(NSString *)role
{
    __block SResponse *response = nil;
    
    [[SKSynergy sharedInstance] addRole:role user:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void) removeRole:(NSString *)role handler:(void (^)(SResponse *result))handler
{
    [[SKSynergy sharedInstance] removeRole:role user:self completion:handler async:YES];
}

-(SResponse *) removeRole:(NSString *)role
{
    __block SResponse *response = nil;
    
    [[SKSynergy sharedInstance] removeRole:role user:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

@end
