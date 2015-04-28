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

#import "SNotification.h"
#import "SKSynergy.h"

@implementation SNotification

@synthesize alert;
@synthesize badge;
@synthesize payload;
@synthesize sound;
@synthesize recipients;

-(instancetype) initWithRecipient:(SynergykitUser *)recipient
{
    self = [super init];
    if (self)
    {
        if (recipient) [self setRecipients:(NSArray<SynergykitUser> *)[NSArray arrayWithObject:recipient]];
    }
    return self;
}

-(instancetype) initWithRecipients:(NSArray<SynergykitUser> *)nRecipients
{
    self = [super init];
    if (self)
    {
        if (nRecipients) [self setRecipients:nRecipients];
    }
    return self;
}

-(instancetype) addRecipient:(SynergykitUser *)recipient
{
    if (recipient)
    {
        NSMutableArray *a = recipients ? [NSMutableArray arrayWithArray:recipients] : [NSMutableArray new];
        [a addObject:recipient];
        
        [self setRecipients:(NSArray<SynergykitUser> *) [NSArray arrayWithArray:a]];
    }
    return self;
}

-(instancetype) addRecipients:(NSArray<SynergykitUser> *)recipientsList
{
    if (recipientsList)
    {
        NSMutableArray *a = recipients ? [NSMutableArray arrayWithArray:recipients] : [NSMutableArray new];
        for (SynergykitUser *user in recipientsList)
        {
            [a addObject:user];
        }
        [self setRecipients:(NSArray<SynergykitUser> *) [NSArray arrayWithArray:a]];
    }
    return self;
}

-(instancetype) alert:(NSString *)a
{
    if (a)
    {
        [self setAlert:a];
    }
    return self;
}

-(instancetype) badge:(NSNumber *)b
{
    if (b)
    {
        [self setBadge:b];
    }
    return self;
}

-(instancetype) payload:(NSString *)p
{
    if (p)
    {
        [self setPayload:p];
    }
    return self;
}

-(instancetype) sound:(NSString *)s
{
    if (s)
    {
        [self setSound:s];
    }
    return self;
}

-(SResponse *) send
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit sendNotificationTo:[self recipientsIds] alert:alert badge:badge payload:payload sound:sound completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void) send:(void (^)(SResponse *result))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit sendNotificationTo:[self recipientsIds] alert:alert badge:badge payload:payload sound:sound completion:handler async:YES];
}

-(NSArray *) recipientsIds
{
    if (recipients && recipients.count > 0)
    {
        NSMutableArray *recipientsIds = [[NSMutableArray alloc] init];
        for (SynergykitObject *recipient in recipients)
        {
            if (recipient._id) [recipientsIds addObject:recipient._id];
        }
        return recipientsIds;
    }
    return [[NSArray alloc] init];
}

@end
