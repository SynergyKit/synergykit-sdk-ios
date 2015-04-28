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

#import "SynergykitUser.h"
#import "SResponse.h"

@interface SEmail : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Optional! The sender of e-mail.
 */
@property (nonatomic, strong) NSString *from;
/**
 *  Required! The recipient of e-mail.
 */
@property (nonatomic, strong) SynergykitUser *to;

/**
 *  Required! The subject of e-mail.
 */
@property (nonatomic, strong) NSString *subject;

/**
 *  Required! Mailing template name.
 */
@property (nonatomic, strong) NSString *templateName;

/**
 *  Mailing template arguments, according to used template.
 */
@property (nonatomic, strong) NSDictionary *args;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes @c SEmail object with @b required properties.
 *
 *  @param to           The recipient of e-mail.
 *  @param subject      The subject of e-mail.
 *  @param templateName Mailing template name.
 *
 *  @return Instance
 */
-(instancetype) initWithRecipient:(SynergykitUser *)to subject:(NSString *)subject template:(NSString *)templateName;

#pragma mark
#pragma mark Object builders
#pragma mark

/**
 *  Sets the sender of e-mail and returns instance object.
 *
 *  @param f The sender of e-mail
 *
 *  @return Instance
 */
-(instancetype) from:(NSString *)f;

/**
 *  Sets the recipient of e-mail and returns instance object.
 *
 *  @param t The recipient of e-mail
 *
 *  @return Instance
 */
-(instancetype) to:(SynergykitUser *)t;

/**
 *  Sets the subject of e-mail and returns instance object.
 *
 *  @param s The subject of e-mail
 *
 *  @return Instance
 */
-(instancetype) subject:(NSString *)s;

/**
 *  Sets mailing template name and returns intance object.
 *
 *  @param t Mailing template name
 *
 *  @return Instance
 */
-(instancetype) templateName:(NSString *)t;

/**
 *  Sets mailing template arguments and returns intance object.
 *
 *  @param a Mailing template arguments
 *
 *  @return Instance
 */
-(instancetype) args:(NSDictionary *)a;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Sends e-mail to recipient according to predefined template @e synchronously.
 *
 *  @return @c SResponse object after completion
 */
-(SResponse *) send;

/**
 *  Send e-mail to recipient according to predefined template @e asynchronously.
 *
 *  @param handler Callback of function
 */
-(void) send:(void (^)(SResponse *result))handler;

@end
