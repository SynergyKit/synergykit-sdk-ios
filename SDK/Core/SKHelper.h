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
#import "JSONModel.h"

@interface SKHelper : NSObject

#pragma mark
#pragma mark NSData —› something
#pragma mark

+(id) fromNSDataToFoundationObject:(NSData *)data error:(NSError **)error;

+(id) fromNSDataToJSONModelObject:(NSData *)data type:(Class)type error:(JSONModelError **)error;

+(NSDictionary *)fromNSDataToNSDictionary:(NSData *)data error:(NSError **)error;

+(NSString *)fromNSDataToNSString:(NSData *)data error:(NSError **)error;

#pragma mark
#pragma mark NSDictionary —› something
#pragma mark

+(NSString *) fromNSDictionaryToNSString:(NSDictionary *)dict error:(NSError **)error;

+(id) fromNSDictionaryToObject:(NSDictionary *)data type:(Class)type error:(JSONModelError **)error;

+(NSData *) fromNSDictionaryToNSData:(NSDictionary *)dict error:(NSError **)error;


@end
