//
//  InnerObject.m
//  sampleapp
//
//  Created by Jan Čislinský on 27/02/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

#import "InnerObject.h"

@implementation InnerObject

-(instancetype) initWithDemo:(DemoObject *)demo name:(NSString *)name
{
    self = [super init];
    if (self)
    {
        if (demo) self.demo = demo;
        if (name) self.demoName = name;
    }
    return self;
}

@end
