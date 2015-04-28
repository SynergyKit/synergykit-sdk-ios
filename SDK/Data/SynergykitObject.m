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
#import "SKSynergy.h"
#import "SynergykitUser.h"

@implementation SynergykitObject

#pragma mark
#pragma mark SynergykitProtocol
#pragma mark

@synthesize __v;
@synthesize _id;
@synthesize collection;
@synthesize endpoint = _endpoint;
@synthesize cache;

#pragma mark
#pragma mark Inicialization
#pragma mark

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _endpoint = @"/data";
    }
    return self;
}

-(instancetype)initWithCollection:(NSString *)nCollection
{
    self = [self init];
    if (self)
    {
        [self setCollection:nCollection];
    }
    return self;
}

-(instancetype) initWithCollection:(NSString *)nCollection _id:(NSString *)n_id ;
{
    self = [self init];
    if (self)
    {
        [self setCollection:nCollection];
        [self set_id:n_id];
    }
    return self;
}

#pragma mark
#pragma mark Object builders
#pragma mark

-(instancetype) __v:(NSNumber *)n__v
{
    if (n__v) [self set__v:n__v];
    return self;
}

-(instancetype) _id:(NSString *)n_id
{
    if (n_id) [self set_id:n_id];
    return self;
}

-(instancetype) collection:(NSString *)nCollection
{
    if (nCollection) [self setCollection:nCollection];
    return self;
}

#pragma mark
#pragma mark SCacheableProtocol
#pragma mark

-(instancetype)cache:(SCache *)nCache
{
    if (nCache) [self setCache:nCache];
    return self;
}

#pragma mark
#pragma mark Synergy Protocol & SBatchableProtocol
#pragma mark

-(SResponse *)save
{
    __block SResponse *response;
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    if (self._id)
    {
        // Update
        [skit updateRecord:self completion:^(SResponse *result) {
            response = result;
        } async:NO];
    }
    else
    {
        // Create
        [skit createRecord:self completion:^(SResponse *result) {
            response = result;
        } async:NO];
    }
    
    return response;
}

-(void)save:(void (^)(SResponse *result))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    if (self._id)
    {
        // Update
        [skit updateRecord:self completion:handler async:YES];
    }
    else
    {
        // Create
        [skit createRecord:self completion:handler async:YES];
    }
}

-(SBatchItemWrapper *)saveInBatch:(void (^)(SResponse *result))handler
{
    if (!self.collection || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"Collection or tenant is nil."];
        return nil;
    }
    
    SBatchItem *item;
    if (self._id)
    {
        // Update
        NSString *batchEndpoint = [NSString stringWithFormat:@"/data/%@/%@", self.collection, self._id];
        item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypePUT endpoint:batchEndpoint body:self];
    }
    else
    {
        // Create
        NSString *batchEndpoint = [NSString stringWithFormat:@"/data/%@", self.collection];
        item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypePOST endpoint:batchEndpoint body:self];
    }
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(SResponse *)fetch
{
    __block SResponse *response;
    
    [[SKSynergy sharedInstance] record:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void)fetch:(void (^)(SResponse *result))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit record:self completion:handler async:YES];
}

-(SBatchItemWrapper *)fetchInBatch:(void (^)(SResponse *result))handler
{
    if (!self._id || !self.collection || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"_id, collection or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/data/%@/%@", self.collection, self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeGET endpoint:batchEndpoint body:self];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(SResponse *)destroy
{
    __block SResponse *response;
    SKSynergy *skit = [SKSynergy sharedInstance];
    
    [skit deleteRecord:self completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void)destroy:(void (^)(SResponse *result))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit deleteRecord:self completion:handler async:YES];
}

-(SBatchItemWrapper *)destroyInBatch:(void (^)(SResponse *result))handler
{
    if (!self._id || !self.collection || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"_id, collection or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/data/%@/%@", self.collection, self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeDELETE endpoint:batchEndpoint body:nil];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:nil handler:handler];
    return wrapper;
}

#pragma mark

@end
