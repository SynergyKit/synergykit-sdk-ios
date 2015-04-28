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

#import "SBatchItem.h"

@implementation SBatchItem

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"_id"}];
}

-(instancetype) _id:(NSNumber *)_id
{
    if (_id) [self set_id:_id];
    return self;
}

-(instancetype) method:(SMethodType)method
{
    if (method) [self setMethod:method];
    return self;
}

-(instancetype) endpoint:(NSString *)endpoint
{
    if (endpoint) [self setEndpoint:endpoint];
    return self;
}

-(instancetype) body:(SynergykitObject *)body
{
    if (body) [self setBody:body];
    return self;
}

-(instancetype) initWithId:(NSNumber *)_id method:(SMethodType)method endpoint:(NSString *)endpoint body:(SynergykitObject *)body
{
    self = [super init];
    if (self)
    {
        [self set_id:_id];
        [self setMethod:method];
        [self setEndpoint:endpoint];
        [self setBody:body];
    }
    return self;
}

-(NSString *) toJSONString
{
    NSMutableDictionary * json = [[NSMutableDictionary alloc] init];
    
    NSString *method;
    SMethodType m = self.method;
    if (m == SMethodTypePOST)
    {
        method = @"POST";
    }
    else if (m == SMethodTypePUT)
    {
        method = @"PUT";
    }
    else if (m == SMethodTypePATCH)
    {
        method = @"PATCH";
    }
    else if (m == SMethodTypeDELETE)
    {
        method = @"DELETE";
    }
    else if (m == SMethodTypeGET)
    {
        method = @"GET";
    }
    
    if (method) [json setValue:method forKey:@"method"];
    if (self._id) [json setValue:self._id forKey:@"id"];
    if (self.endpoint) [json setValue:self.endpoint forKey:@"endpoint"];
    if (self.body) [json setValue:[self.body toJSONString] forKey:@"body"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    NSString* newStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (!newStr) {
        return nil;
    } else {
        NSString *properString = [[[[newStr stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"] stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"] stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"] stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
        return properString;
    }
}

@end
