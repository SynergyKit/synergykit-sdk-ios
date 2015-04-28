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

#import "SResponseWrapper.h"

@implementation SResponseWrapper

@synthesize responses;

-(instancetype) initWithResponse:(SResponse *)response
{
    self = [super init];
    if (self)
    {
        if (response) [self setResponses:[NSArray arrayWithObject:response]];
    }
    return self;
}

-(instancetype) initWithResponses:(NSArray *)nResponses
{
    self = [super init];
    if (self)
    {
        if (nResponses) [self setResponses:[NSArray arrayWithArray:nResponses]];
    }
    return self;
}

-(void) addResponse:(SResponse *)response
{
    NSMutableArray *a = [NSMutableArray arrayWithArray:responses];
    [a addObject:response];
    
    responses = [NSArray arrayWithArray:a];
}

-(BOOL) succeeded
{
    if (!responses || responses.count == 0)
    {
        return NO;
    }
    
    for (SResponse *r in responses)
    {
        if (!r.succeeded)
        {
            return NO;
        }
    }
    return YES;
}

-(NSArray *) results
{
    if (!responses || responses.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:responses.count];
    
    for (SResponse *r in responses)
    {
        if (r.result) [results addObject:r.result];
    }
    
    return [NSArray arrayWithArray:results];
}

-(NSArray *) errors
{
    if (!responses || responses.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *errors = [[NSMutableArray alloc] initWithCapacity:responses.count];
    
    for (SResponse *r in responses)
    {
        if (r.error) [errors addObject:r.error];
    }
    
    return [NSArray arrayWithArray:errors];
}

-(NSString *)description
{
    NSMutableString *s = [NSMutableString new];
    [s appendFormat:@"__Wrapper %@__\n", [self succeeded] ? @"SUCCEEDED" : @"FAILED"];
    
    int i = 1;
    for (SResponse *r in responses)
    {
        [s appendFormat:@"%d) %@\n\n", i++, r.description];
    }
    return s;
}

@end
