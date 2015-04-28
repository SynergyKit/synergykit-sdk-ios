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

@interface SCloudCode : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Required! Function name
 */
@property (nonatomic, strong) NSString * name;

/**
 *  Parameters to pass into function.
 */
@property (nonatomic, strong) NSDictionary * args;

/**
 *  Type of returned data. If is set to @b nil, result will be returned as @b NSDictionary.
 */
@property (nonatomic) Class resultType;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes object with function @b name, @b arguments that will be used in function and result object @b type.
 *
 *  @param name Function name
 *  @param args Parameters to pass into function like in Example.
 *  @param type Type of returned data. If is set to nil, result will be returned as NSDictionary.
 *
 *  @return Initialized instance
 */
-(instancetype) initWithName:(NSString *)name args:(NSDictionary *)args resultType:(Class)type;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Invokes Synergykit CloudCode @e asynchronously.
 *
 *  @param completion Callback of function
 */
-(void) invoke:(void (^)(SResponse *result))completion;

/**
 * Invokes Synergykit CloudCode @e synchronously.
 *
 *  @return @c SResponse object after completion
 */
-(SResponse *) invoke;

#pragma mark

@end
