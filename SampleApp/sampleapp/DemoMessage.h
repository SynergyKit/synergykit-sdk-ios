//
//  DemoMessage.h
//  sampleapp
//
//  Created by Jan Čislinský on 24/02/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

#import "DemoObject.h"

typedef NS_ENUM(NSInteger, DemoMessageType) {
    
    DemoMessageTypeIncoming = 0,
    DemoMessageTypeMy = 1,
    DemoMessageTypeState = 2
};

@interface DemoMessage : DemoObject

@property (nonatomic, retain) NSString<Optional> * name;
@property (nonatomic, retain) NSString<Optional> * userId;

@end

