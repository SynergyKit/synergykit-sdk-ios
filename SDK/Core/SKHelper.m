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

#import "SKHelper.h"
#import "SKSynergy.h"

@implementation SKHelper

+(id)fromNSDataToFoundationObject:(NSData *)data error:(NSError **)error
{
    return data != nil ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error] : nil;
}

+(NSDictionary *)fromNSDataToNSDictionary:(NSData *)data error:(NSError **)error
{
    return data != nil ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error] : nil;
}

+(NSString *)fromNSDataToNSString:(NSData *)data error:(NSError **)error
{
    return data != nil ? [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error] : nil;
}

+(NSString *) fromNSDictionaryToNSString:(NSDictionary *)dict error:(NSError **)error
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:error];
    if(!data && error)
    {
        return nil;
    }
    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    // Replace escaped
    string = [string stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    
    return string;
}

+(id) fromNSDataToJSONModelObject:(NSData *)data type:(Class)type error:(JSONModelError **)error
{
    id object = nil;
    if (type)
    {
        NSString *objectJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (objectJson == nil || [objectJson isEqualToString:@"null"] || [objectJson isEqualToString:@""])
        {
            return nil;
        }
        
        object = [[type alloc] initWithString:objectJson usingEncoding:NSUTF8StringEncoding error:error];
    }
    else
    {
        object = [self fromNSDataToNSDictionary:data error:error];
    }
    
    return object;
}

+(id) fromNSDictionaryToObject:(NSDictionary *)data type:(Class)type error:(JSONModelError **)error
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:error];
    NSString *jsonString;
    
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    if (jsonData == nil || jsonString == nil || [jsonString isEqualToString:@"null"] || [jsonString isEqualToString:@""])
    {
        return nil;
    }
    
    id object = [[type alloc] initWithString:jsonString usingEncoding:NSUTF8StringEncoding error:error];
    
    return object;
}

+(NSData *) fromNSDictionaryToNSData:(NSDictionary *)dict error:(NSError **)error
{
    return [[self fromNSDictionaryToNSString:dict error:error] dataUsingEncoding:NSUTF8StringEncoding];
}
@end
