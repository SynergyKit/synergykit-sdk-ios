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

#import <Foundation/Foundation.h>
#import "SBatchItemWrapper.h"
#import "SBatchResponse.h"
#import "SResponseWrapper.h"

@interface SBatch : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Items that will be executed in batch request.
 */
@property (nonatomic, strong) NSMutableArray<SBatchItemWrapper> *items;


#pragma mark
#pragma mark Object builders
#pragma mark

/**
 *  Adds item to list of items.
 *
 *  @param item Item that will be executed in batch request
 *
 *  @return Object instance
 */
-(instancetype) addItem:(SBatchItemWrapper *)item;

/**
 *  Adds list of items to list of items.
 *
 *  @param items List of items that will be executed in batch request
 *
 *  @return Object instance
 */
-(instancetype) addItems:(NSArray<SBatchItemWrapper> *)items;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Executes batch request with all inserted items.
 *
 *  @attention Every @c SResponse in result wrapper contains result object (fetching, creating, updating, querying with @c top(1)) or @b array of objects (querying without @c top(1)).
 *
 *  @param completion Callback for implicit handling of all items responses. But every item can have own response handler, so be careful with multiple handling.
 *
 */
-(void) executeWithCompletion:(void (^)(SResponseWrapper *result))completion;

@end
