//
//  DemoObject.m
//  synergykit-sdk-ios-demo
//
//  Created by Jan Čislinský on 15/10/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

#import "DemoObject.h"

@implementation DemoObject

-(instancetype) initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        self.text = text;
    }
    return self;
}

@end
