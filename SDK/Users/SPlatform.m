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

#import "SPlatform.h"
#import "SKSynergy.h"

@implementation SPlatform

@synthesize endpoint = _endpoint;
@synthesize _id;

#pragma mark
#pragma mark Initialization
#pragma mark

-(instancetype) init
{
    self = [super init];
    if (self)
    {
        [self setPlatformName:@"apple"];
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
#pragma mark SynergykitProtocol & SBatchableProtocol
#pragma mark

-(void)save:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    if (self._id)
    {
        // Update
        [skit updatePlatform:self completion:handler async:YES];
    }
    else
    {
        // Create
        [skit createPlatform:self completion:handler async:YES];
    }
}

-(SResponse *)save
{
    __block SResponse *response;
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    if (self._id)
    {
        // Update
        [skit updatePlatform:self completion:^(SResponse *result) {
            response = result;
        } async:NO];
    }
    else
    {
        // Create
        [skit createPlatform:self completion:^(SResponse *result) {
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
        NSString *batchEndpoint = [NSString stringWithFormat:@"/users/me/platforms/%@", self._id];
        item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypePUT endpoint:batchEndpoint body:self];
    }
    else
    {
        // Create
        NSString *batchEndpoint = [NSString stringWithFormat:@"/users/me/platforms"];
        item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypePOST endpoint:batchEndpoint body:self];
    }
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(void)fetch:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit platform:self completion:handler async:YES];
}

-(SResponse *)fetch
{
    __block SResponse *response;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit platform:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(SBatchItemWrapper *)fetchInBatch:(void (^)(SResponse *))handler
{
    if (!self._id || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"Self._id or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/users/me/platforms/%@", self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeGET endpoint:batchEndpoint body:self];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(void)destroy:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit deletePlatform:self completion:handler async:YES];
}

-(SResponse *)destroy
{
    __block SResponse *response;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit deletePlatform:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(SBatchItemWrapper *)destroyInBatch:(void (^)(SResponse *))handler
{
    if (!self._id || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"Self._id or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/users/me/platforms/%@", self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeDELETE endpoint:batchEndpoint body:nil];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:nil handler:handler];
    return wrapper;
}

#pragma mark

@end
