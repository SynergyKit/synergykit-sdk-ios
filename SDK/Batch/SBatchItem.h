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
#import "SMethodType.h"

@protocol BatchItem @end

@interface SBatchItem : JSONModel

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Required! Idetificator of request.
 */
@property (nonatomic, retain) NSNumber * _id;

/**
 *  Required! Method of request.
 */
@property (nonatomic) SMethodType method;

/**
 *  Required! Endpoint of request. Endpoint is specified as part of url after api version —› ….synergykit.com/vX.X<-- there is endpoint (starts with /) -->
 */
@property (nonatomic, retain) NSString * endpoint;

/**
 *  Optional! Request body.
 */
@property (nonatomic, retain) SynergykitObject * body;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Basic initializer.
 *
 *  @param _id    Idetificator of request
 *  @param method Method of request
 *  @param endpoint    Endpoint of request
 *  @param body Request body
 *
 *  @return Initialized instance
 */
-(instancetype) initWithId:(NSNumber *)_id method:(SMethodType)method endpoint:(NSString *)endpoint body:(SynergykitObject *)body;

#pragma mark
#pragma mark Object builders
#pragma mark

/**
 *  Sets request identificator
 *
 *  @param _id Idetificator of request
 *
 *  @return Instance object
 */
-(instancetype) _id:(NSNumber *)_id;

/**
 *  Sets method for requet
 *
 *  @param method Method of request
 *
 *  @return Instance object
 */
-(instancetype) method:(SMethodType)method;

/**
 *  Sets endpoint for request
 *
 *  @param url Endpoint of request
 *
 *  @return Instance object
 */
-(instancetype) endpoint:(NSString *)endpoint;

/**
 *  Sets request body of request
 *
 *  @param body Request body
 *
 *  @return Instance object
 */
-(instancetype) body:(SynergykitObject *)body;


@end
