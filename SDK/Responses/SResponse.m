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

#import "SResponse.h"

@implementation SResponse

@synthesize result;
@synthesize error;

-(instancetype) initWithResult:(id)nResult error:(NSError *)nError
{
    self = [super init];
    if (self)
    {
        [self setResult:nResult];
        [self setError:nError];
    }
    return self;
}

-(BOOL) succeeded
{
    return error == nil ? YES : NO;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%s\n%@", self.succeeded ? "SUCCEEDED, result:" : "FAILED, error:", self.succeeded ? self.result : self.error.userInfo[NSLocalizedDescriptionKey]];
}

@end
