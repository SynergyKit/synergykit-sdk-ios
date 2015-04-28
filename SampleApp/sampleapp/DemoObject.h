//
//  DemoObject.h
//  synergykit-sdk-ios-demo
//
//  Created by Jan Čislinský on 15/10/14.
//  Copyright (c) 2014 Letsgood.com s.r.o. All rights reserved.
//

#import "SynergykitObject.h"

@interface DemoObject : SynergykitObject

@property (nonatomic, retain) NSString<Optional> * text;

-(instancetype) initWithText:(NSString *)text;

@end
