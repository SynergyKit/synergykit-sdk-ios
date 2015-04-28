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

#import <Foundation/Foundation.h>
#import "SynergykitUser.h"
#import "SResponse.h"

@interface SNotification : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Optional! Alert message of notification.
 */
@property (nonatomic, strong) NSString *alert;

/**
 *  Optional! Badge to be shown on app icon.
 */
@property (nonatomic, strong) NSNumber *badge;

/**
 *  Optional! Notification payload.
 */
@property (nonatomic, strong) NSString *payload;

/**
 *  Optional! Sound to be played on notification income.
 */
@property (nonatomic, strong) NSString *sound;

/**
 *  Required! List of recipients for whom notification will be send.
 */
@property (nonatomic, strong) NSArray<SynergykitUser> *recipients;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Basic initializer for single recipient.
 *
 *  @param recipient Recipient for which notification will be send.
 *
 *  @return Initialized instance
 */
-(instancetype) initWithRecipient:(SynergykitUser *)recipient;

/**
 *  Basic initializer for multiple recipient.
 *
 *  @param recipient List of recipients for whom notification will be send.
 *
 *  @return Initialized instance
 */
-(instancetype) initWithRecipients:(NSArray<SynergykitUser> *)recipientsList;

#pragma mark
#pragma mark Object builders
#pragma mark

/**
 *  Adds recipient to list of recipients.
 *
 *  @param recipient Recipient for which notification will be send.
 */
-(instancetype) addRecipient:(SynergykitUser *)recipient;

/**
 *  Adds recipients to list of recipients.
 *
 *  @param recipientsList Recipients for which notification will be send.
 */
-(instancetype) addRecipients:(NSArray<SynergykitUser> *)recipientsList;

/**
 *  Sets alert and returns instance object.
 *
 *  @param a Alert message of notification.
 *
 *  @return Instance object
 */
-(instancetype) alert:(NSString *)a;

/**
 *  Sets badge and returns instance object.
 *
 *  @param b Badge to be shown on app icon.
 *
 *  @return Instance object
 */
-(instancetype) badge:(NSNumber *)b;

/**
 *  Sets payload and returns instance object.
 *
 *  @param p Notification payload.
 *
 *  @return Instance object
 */
-(instancetype) payload:(NSString *)p;

/**
 *  Sets sound and returns instance object.
 *
 *  @param s Sound to be player on notification income.
 *
 *  @return Instance object
 */
-(instancetype) sound:(NSString *)s;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Sends notification @e synchronously to list of recipients with alert, badge, sound and payload that were set.
 *
 *  @return @c SResponse object after completion
 */
-(SResponse *) send;

/**
 *  Sends notification @e asynchronously to list of recipients with alert, badge, sound and payload that were set.
 *
 *  @param handler Callback of function
 */
-(void) send:(void (^)(SResponse *result))handler;

@end
