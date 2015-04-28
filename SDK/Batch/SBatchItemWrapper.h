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
#import "SBatchItem.h"
#import "SBatchResponse.h"

@interface SBatchItemWrapper : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Required! Batch request item.
 */
@property (nonatomic, strong) SBatchItem *item;

/**
 *  Optional! Return type of data for deserialization.
 */
@property (nonatomic) Class type;

/**
 *  Optional! Callback for this item in batch request.
 */
@property (nonatomic, strong) void (^handler)(SResponse *result);

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes object with @b item, return object @b type and explicit @b handler.
 *
 *  @param item    Batch request item
 *  @param type    Return type of data for deserialization
 *  @param handler Callback for this item in batch request
 *
 *  @return Initialized instance
 */
-(instancetype) initWithItem:(SBatchItem *)item  type:(Class)type handler:(void (^)(SResponse *result))handler;

@end
