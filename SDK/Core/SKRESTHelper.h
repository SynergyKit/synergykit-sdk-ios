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

@interface SKRESTHelper : NSObject @end

static  NSString * const GET = @"GET";
static  NSString * const POST = @"POST";
static  NSString * const PUT = @"PUT";
static  NSString * const CONFLICT = @"CONFLICT";
static  NSString * const DELETE = @"DELETE";
static  NSString * const LAST = @"LAST";

static  NSString * const PLATFORM_APPLE = @"apple";

#define SKIT_API [NSString stringWithFormat:@"https://%@.api.synergykit.com", [[SKSynergy sharedInstance] tenant]]
//#define SKIT_API @"http://172.22.0.104:5078"

#define API_WITH_VERSION [SKIT_API stringByAppendingString:@"/v2.1"]

// Filters
#define GET_FILTER_BASE [API_WITH_VERSION stringByAppendingString:@"%@%@"]

// Records
#define GET_RECORD [API_WITH_VERSION stringByAppendingString:@"/data/%@/%@"]
#define POST_CREATE_RECORD [API_WITH_VERSION stringByAppendingString:@"/data/%@"]
#define PUT_UPDATE_RECORD [API_WITH_VERSION stringByAppendingString:@"/data/%@/%@"]
#define DELETE_RECORD [API_WITH_VERSION stringByAppendingString:@"/data/%@/%@"]

// Batch
#define BATCH [API_WITH_VERSION stringByAppendingString:@"/batch"]

// Files
#define POST_CREATE_FILE [API_WITH_VERSION stringByAppendingString:@"/files"]
#define GET_FILE [API_WITH_VERSION stringByAppendingString:@"/files/%@"]
#define DELETE_FILE [API_WITH_VERSION stringByAppendingString:@"/files/%@"]

// Users
#define GET_ALL_USERS [API_WITH_VERSION stringByAppendingString:@"/users"]
#define GET_USER [API_WITH_VERSION stringByAppendingString:@"/users/%@"]
#define POST_CREATE_USER [API_WITH_VERSION stringByAppendingString:@"/users"]
#define PUT_UPDATE_USER [API_WITH_VERSION stringByAppendingString:@"/users/%@"]
#define DELETE_USER [API_WITH_VERSION stringByAppendingString:@"/users/%@"]

#define ADD_ROLE [API_WITH_VERSION stringByAppendingString:@"/users/%@/roles"]
#define UPDATE_ROLE [API_WITH_VERSION stringByAppendingString:@"/users/%@/roles"]
#define DELETE_ROLE [API_WITH_VERSION stringByAppendingString:@"/users/%@/roles/%@"]

#define ACTIVATE_USER [API_WITH_VERSION stringByAppendingString:@"/users/activation/%@"]
#define LOGIN_USER [API_WITH_VERSION stringByAppendingString:@"/users/login"]

#define ADD_PLATFORM [API_WITH_VERSION stringByAppendingString:@"/users/me/platforms"]
#define GET_PLATFORM [API_WITH_VERSION stringByAppendingString:@"/users/me/platforms/%@"]
#define UPDATE_PLATFORM [API_WITH_VERSION stringByAppendingString:@"/users/me/platforms/%@"]
#define DELETE_PLATFORM [API_WITH_VERSION stringByAppendingString:@"/users/me/platforms/%@"]


// Mail and Notification
#define SEND_MAIL [API_WITH_VERSION stringByAppendingString:@"/mail/%@"]
#define SEND_NOTIFICATION [API_WITH_VERSION stringByAppendingString:@"/users/notification"]

// Cloud Code
#define POST_CLOUD_CODE [API_WITH_VERSION stringByAppendingString:@"/functions/%@"]
