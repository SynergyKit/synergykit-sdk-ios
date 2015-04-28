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
#import "SResponse.h"

@interface SResponseWrapper : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Array of @c SResponse objects.
 */
@property (nonatomic, strong) NSArray *responses;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes object with @c SResponse.
 *
 *  @param response Single response object
 *
 *  @return Instance
 */
-(instancetype) initWithResponse:(SResponse *)response;

/**
 *  Initializes object with array of @c SResponse.
 *
 *  @param responses Array of responses
 *
 *  @return Instance
 */
-(instancetype) initWithResponses:(NSArray *)responses;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Adds response to wrapper.
 *
 *  @param response Single response object
 */
-(void) addResponse:(SResponse *)response;

/**
 *  Determines that the request with multiple results @b succeeded or @b failed.
 *
 *  @return YES if @c responses != nil && @c responses.count > 0 && every response succeeded
 */
-(BOOL) succeeded;

/**
 *  Returns array of result objects. Count of returned array may not match count of responses array because some response could be failed.
 *
 *  @return Array of result objects.
 */
-(NSArray *) results;

/**
 *  Returns array of error objects. Array could be empty if every response succeeded.
 *
 *  @return Array of error objects.
 */
-(NSArray *) errors;

@end
