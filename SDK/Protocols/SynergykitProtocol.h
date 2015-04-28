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

#ifndef SynergyKit_SynergyProtocol_h
#define SynergyKit_SynergyProtocol_h

@class SResponse;

/**
 *  Base Synergy protocol that provides interface for basic communication with API.
 */
@protocol SynergykitProtocol

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Initializes object with collection.
 *
 *  @param collection Name of collection
 *
 *  @return Instance
 */
-(instancetype) initWithCollection:(NSString *)name;

#pragma mark
#pragma mark Synchronous methods
#pragma mark

/**
 * Saves object data to the server @e synchronously.
 *
 *  @return Dictionary contains:
 – object for key "result" if succeed
 – object for key "error" if request failed
 */
-(SResponse *) save;

/**
 * Fetches data object from the server @e synchronously.
 *
 *  @return Dictionary contains:
 – object for key "result" if succeed
 – object for key "error" if request failed
 */
-(SResponse *) fetch;

/**
 * Deletes object on the server @e synchronously.
 *
 *  @return Error object or nil if succeed.
 */
-(SResponse *) destroy;

#pragma mark
#pragma mark Asynchronous methods
#pragma mark

/**
 *  Saves object data to the server @e asynchronously.
 *
 *  @param handler Callback contains:
 – result as resultType
 – error if request failed
 */
-(void) save:(void (^)(SResponse *result))handler;

/**
 *  Fetchs data object from the server @e asynchronously.
 *
 *  @param handler Callback contains:
 – result as resultType
 – error if request failed
 */
-(void) fetch:(void (^)(SResponse *result))handler;

/**
 *  Deletes object on the server @e asynchronously.
 *
 *  @param handler Callback contains:
 – error if request failed
 */
-(void) destroy:(void (^)(SResponse *result))handler;

@end

#pragma mark
#pragma mark JSONModel deserialization helper protocols
#pragma mark

/**
 *  Protocol for JSONModel deserialization.
 */
@protocol SynergykitObject @end
/**
 *  Protocol for JSONModel deserialization.
 */
@protocol SPlatform @end
/**
 *  Protocol for JSONModel deserialization.
 */
@protocol SynergykitUser @end
/**
 *  Protocol for JSONModel deserialization.
 */
@protocol SBatchItemWrapper @end
/**
 *  Protocol for JSONModel deserialization.
 */
@protocol SBatchResponse @end

#endif