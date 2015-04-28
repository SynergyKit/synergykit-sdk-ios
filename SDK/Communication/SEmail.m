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

#import "SEmail.h"
#import "SKSynergy.h"

@implementation SEmail

@synthesize from;
@synthesize to;
@synthesize subject;
@synthesize templateName;
@synthesize args;

#pragma mark
#pragma mark Object builders
#pragma mark

-(instancetype) initWithRecipient:(SynergykitUser *)nTo subject:(NSString *)nSubject template:(NSString *)nTemplateName
{
    self = [super init];
    if (self)
    {
        [self setTo:nTo];
        [self setSubject:nSubject];
        [self setTemplateName:nTemplateName];
    }
    return self;
}

#pragma mark
#pragma mark Object builders
#pragma mark

-(instancetype) from:(NSString *)f
{
    if (f)
    {
        [self setFrom:f];
    }
    return self;
}

-(instancetype) to:(SynergykitUser *)t
{
    if (t)
    {
        [self setTo:t];
    }
    return self;
}


-(instancetype) subject:(NSString *)s
{
    if (s)
    {
        [self setSubject:s];
    }
    return self;
}

-(instancetype) templateName:(NSString *)t
{
    if (t)
    {
        [self setTemplateName:t];
    }
    return self;
}

-(instancetype) args:(NSDictionary *)a
{
    if (a)
    {
        [self setArgs:a];
    }
    return self;
}

#pragma mark
#pragma mark Instance methods
#pragma mark

-(SResponse *) send;
{
    __block SResponse *response = nil;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit sendEmailTo:to.email from:from subject:subject template:templateName formVars:args completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void) send:(void (^)(SResponse *result))handler;
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit sendEmailTo:to.email from:from subject:subject template:templateName formVars:args completion:handler async:YES];
}

@end
