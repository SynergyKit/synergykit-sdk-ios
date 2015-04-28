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

#import "SCloudCode.h"
#import "SKSynergy.h"

@implementation SCloudCode

-(instancetype) initWithName:(NSString *)name args:(NSDictionary *)args resultType:(Class)type
{
    self = [super init];
    if (self)
    {
        [self setName:name];
        [self setArgs:args];
        [self setResultType:type];
    }
    return self;
}

-(void) invoke:(void (^)(SResponse *result))completion
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit invokeCloudCode:self.name resultType:self.resultType codeVars:self.args completion:completion async:YES];
}

-(SResponse *) invoke;
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit invokeCloudCode:self.name resultType:self.resultType codeVars:self.args completion:^void(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}


@end
