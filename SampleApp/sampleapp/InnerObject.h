//
//  InnerObject.h
//  sampleapp
//
//  Created by Jan Čislinský on 27/02/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

#import "SynergykitObject.h"
#import "DemoObject.h"

@interface InnerObject : SynergykitObject

@property (nonatomic, retain) DemoObject *demo;
@property (nonatomic, retain) NSString *demoName;

-(instancetype) initWithDemo:(DemoObject *)demo name:(NSString *)name;

@end
