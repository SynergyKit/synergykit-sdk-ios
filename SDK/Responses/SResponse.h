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

@interface SResponse : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  @b Result object, it could be @c NSDictionary, @c SBatchResponse or @b deserialized object according to predefined @b type.
 */
@property (nonatomic, strong) id result;

/**
 *  @b Error object if request or deserialization failed.
 */
@property (nonatomic, strong) NSError *error;

#pragma mark
#pragma mark Initializaiton
#pragma mark
/**
 *  Initializes object with result object and error object.
 *
 *  @param result @b Result object, it could be @c NSDictionary, @c SBatchResponse or @b deserialized object according to predefined @b type.
 *  @param error  @b Error object if request or deserialization failed.
 *
 *  @return Instance
 */
-(instancetype) initWithResult:(id)result error:(NSError *)error;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Determines that the request @b succeeded or @b failed.
 *
 *  @return YES if error == nil
 */
-(BOOL) succeeded;

@end
