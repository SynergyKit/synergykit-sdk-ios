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
#import "SBatchItem.h"

@interface SBatchResponse : JSONModel

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Status code of item request.
 */
@property (nonatomic, strong) NSNumber * statusCode;

/**
 *  Status of item request.
 */
@property (nonatomic, strong) NSString<Optional> * status;

/**
 *  Message of item request.
 */
@property (nonatomic, strong) NSString<Optional> * message;

/**
 *  Code of item request.
 */
@property (nonatomic, strong) NSString<Optional> * code;

/**
 *  Request body of item request.
 */
@property (nonatomic, strong) id<Optional> body;

/**
 *  Request item for which is response.
 */
@property (nonatomic, strong) SBatchItem <Ignore> * requestItem;

@end
