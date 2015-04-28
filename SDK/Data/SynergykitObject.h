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
#import "SynergykitProtocol.h"
#import "SBatchableProtocol.h"
#import "SCacheableProtocol.h"

/**
 *  Base Synergy object from witch every object need to be inherited.
 */
@interface SynergykitObject : JSONModel <SynergykitProtocol, SBatchableProtocol, SCacheableProtocol>

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Object version
 */
@property (nonatomic, strong) NSNumber<Optional>* __v;

/**
 *  API identificator
 */
@property (nonatomic, strong) NSString<Optional>* _id;

/**
 *  Time of creation in millis since 1970.
 */
@property (nonatomic, strong) NSNumber<Optional>* createdAt;

/**
 *  Time of update in millis since 1970.
 */
@property (nonatomic, strong) NSNumber<Optional>* updatedAt;

/**
 *  Name of collection where object is/will be situated.
 */
@property (nonatomic, strong) NSString<Ignore> * collection;

/**
 *  Determines API endpoint /data, /users, /files, …
 */
@property (nonatomic, strong, readonly) NSString<Ignore> *endpoint;

#pragma mark
#pragma mark Initializaiton
#pragma mark

/**
 *  Initializes object with object._id and collection. After this init you can call @b object.fetch().
 *
 *  @param collection Name of collection where object is situated
 *  @param _id        API identificator.
 *
 *  @return Instance
 */
-(instancetype) initWithCollection:(NSString *)collection _id:(NSString *)_id ;

#pragma mark
#pragma mark Object builders
#pragma mark

/**
 *  Sets __v a return object.
 *
 *  @param __v Object version
 *
 *  @return Instance
 */
-(instancetype) __v:(NSNumber *)__v;

/**
 *  Sets _id and return object.
 *
 *  @param _id API identificator
 *
 *  @return Instance
 */
-(instancetype) _id:(NSString *)_id;

/**
 *  Sets collection and return object.
 *
 *  @param collection Name of collection where object is situated
 *
 *  @return Instance
 */
-(instancetype) collection:(NSString *)collection;

@end