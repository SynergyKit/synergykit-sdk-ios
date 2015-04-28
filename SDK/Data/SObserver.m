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

#import "SObserver.h"
#import "SKSynergy.h"

@interface SObserver()

/**
 *  Required! Object that determines observed collection, result type and filter. @b SynergykitObject or @b SQuery could be used.
 */
@property (nonatomic, strong) id object;


@end

@implementation SObserver

#pragma mark
#pragma mark Properties
#pragma mark

@synthesize object;
@synthesize event = _event;
@synthesize collection;
@synthesize filter;
@synthesize _id = __id;
@synthesize objectHandler = _objectHandler;
@synthesize stateHandler = _stateHandler;
@synthesize filterName;
@synthesize speakName;
@synthesize resultType;

#pragma mark
#pragma mark Initialization
#pragma mark

-(instancetype) initWithObject:(SynergykitObject *)o event:(SMethodType)e;
{
    self = [super init];
    if (self)
    {
        __id = [self generateId];
        [self setObject:o];
        
        if (e == SMethodTypePOST)
        {
            _event = @"created";
        }
        else if (e == SMethodTypePUT)
        {
            _event = @"updated";
        }
        else if (e == SMethodTypePATCH)
        {
            _event = @"patched";
        }
        else if (e == SMethodTypeDELETE)
        {
            _event = @"deleted";
        }
    }
    return self;
}

-(instancetype) initWithObject:(SQuery *)o queryName:(NSString *)name event:(SMethodType)e
{
    self = [super init];
    if (self)
    {
        __id = [self generateId];
        [self setObject:o];
        [self setFilterName:name];
        
        if (e == SMethodTypePOST)
        {
            _event = @"created";
        }
        else if (e == SMethodTypePUT)
        {
            _event = @"updated";
        }
        else if (e == SMethodTypePATCH)
        {
            _event = @"patched";
        }
        else if (e == SMethodTypeDELETE)
        {
            _event = @"deleted";
        }
    }
    return self;
}

-(instancetype) initWithSpeakName:(NSString *)speak
{
    self = [super init];
    if (self)
    {
        __id = [self generateId];
        [self setSpeakName:speak];
    }
    return self;
}

#pragma mark
#pragma mark Instance methods
#pragma mark

-(instancetype) startObservingWithObjectHandler:(void (^)(id result))objectHandler stateHandler:(void (^)(SObserverState state, NSArray *errors))stateHandler
{
    if ((([self collection] && _event) || speakName) && objectHandler)
    {
        _objectHandler = objectHandler;
        _stateHandler = stateHandler;
        [[SKSynergy sharedInstance] startObserving:self];
    }
    else
    {
        [SKSynergy errorLog:@"SObserver: Object, object.collection, event or handler is nil."];
    }

    return self;
}

-(instancetype) speakWithObject:(id)o
{
    if (o) object = o;
    [[SKSynergy sharedInstance] sendSpeak:self];
    return self;
}

-(void) stopObserving
{
    [[SKSynergy sharedInstance] stopObserving:self];
}

-(BOOL) isValid
{
    if (!_objectHandler)
    {
        return NO;
    }
    
    if (speakName)
    {
        return YES;
    }
    else if (_event && object)
    {
        if ([object isKindOfClass:SynergykitObject.class] && ((SynergykitObject *)object).collection)
        {
            return YES;
        }
        else if ([object isKindOfClass:SQuery.class] && ((SQuery *)object).object.collection)
        {
            return YES;
        }
    }
    return NO;
}

+(void) stopAllObservers
{
    [[SKSynergy sharedInstance] stopAllObservers];
}

+(id<SObserverConnectionDelegate>) connectionDelegate
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    return skit.observersConnectionDelegate;
}

+(void) connectionDelegate:(id<SObserverConnectionDelegate>)delegate
{
    if (delegate)
    {
        SKSynergy *skit = [SKSynergy sharedInstance];
        skit.observersConnectionDelegate = delegate;
    }
}

#pragma mark
#pragma mark Getters
#pragma mark

-(NSString *)key
{
    // Speak observing
    if (speakName)
    {
        return speakName;
    }
    
    // Data observing
    if (!_event)
    {
        [SKSynergy errorLog:@"SObserver event is nil."];
        return nil;
    }
    
    NSMutableString *key = [NSMutableString stringWithString:_event];
    
    if (object)
    {
        if ([object isKindOfClass:SynergykitObject.class] && ((SynergykitObject *)object).collection)
        {
            [key appendFormat:@"_%@", ((SynergykitObject *)object).collection];
            return key;
        }
        else if ([object isKindOfClass:SQuery.class] && ((SQuery *)object).object.collection)
        {
            [key appendFormat:@"_%@", ((SQuery *)object).object.collection];
            
            if (((SQuery *)object).urlExtension)
            {
                if (filterName)
                {
                    [key appendFormat:@"_%@", filterName];
                }
                else
                {
                    [key appendFormat:@"_%@", __id]; // observer._id is used as filter name
                }
                
            }
            return key;
        }
    }
    
    [SKSynergy errorLog:@"SObserver object or object.collection is nil."];
    return nil;
}

-(NSString *)collection
{
    if (object)
    {
        if ([object isKindOfClass:SynergykitObject.class] && ((SynergykitObject *)object).collection)
        {
            return ((SynergykitObject *)object).collection;
        }
        else if ([object isKindOfClass:SQuery.class] && ((SQuery *)object).object.collection)
        {
            return ((SQuery *)object).object.collection;
        }
    }
    return nil;
}

-(NSString *)filter
{
    if (object)
    {
        if ([object isKindOfClass:SQuery.class] && ((SQuery *)object).object.collection && ((SQuery *)object).urlExtension)
        {
            return ((SQuery *)object).filterQueryString;
        }
    }
    return nil;
}

-(Class)resultType
{
    if (resultType)
    {
        // Result type for results from speak observing – speak don't have object
        return resultType;
    }
    else if (object)
    {
        if ([object isKindOfClass:SynergykitObject.class] && ((SynergykitObject *)object).collection)
        {
            return ((SynergykitObject *)object).class;
        }
        else if ([object isKindOfClass:SQuery.class] && ((SQuery *)object).object.collection)
        {
            return ((SQuery *)object).object.class;
        }
    }
    return nil;
}

-(NSDictionary *)subscribeArgs
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    dict[@"tenant"] = [[SKSynergy sharedInstance] tenant];
    
    dict[@"key"] = [[SKSynergy sharedInstance] applicationKey];
    
    if ([[SKSynergy sharedInstance] sessionToken]) dict[@"token"] = [[SKSynergy sharedInstance] sessionToken];
    
    if (speakName)
    {
        // Speak
        dict[@"eventName"] = speakName;
    }
    else
    {
        // Emit
        dict[@"collectionName"] = [self collection];
        dict[@"eventName"] = _event;
        NSString *filterString = [self filter];
        if (filterString)
        {
            NSString *filterNameString = filterName ? filterName : __id;
            dict[@"filter"] = [NSDictionary dictionaryWithObjectsAndKeys:filterString, @"query", filterNameString, @"name", nil];
        }
    }
    return dict;
}

-(NSDictionary *)speakArgs
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"tenant"] = [[SKSynergy sharedInstance] tenant];
    dict[@"key"] = [[SKSynergy sharedInstance] applicationKey];
    if ([[SKSynergy sharedInstance] sessionToken]) dict[@"token"] = [[SKSynergy sharedInstance] sessionToken];
    if (speakName)
    {
        // Speak
        dict[@"eventName"] = speakName;
        if (object)
        {
            if ([object isKindOfClass:SynergykitObject.class])
            {
                dict[@"message"] = [object toDictionary];
            }
            else
            {
                dict[@"message"] = object;
            }
        }
    }
    return dict;
}

#pragma mark
#pragma mark Helpers
#pragma mark

-(BOOL)isEqual:(id)sObject
{
    SObserver *o = (SObserver *) sObject;
    return [o._id isEqualToString:self._id];
}


-(NSString *) generateId
{
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 20; i++)
    {
        u_int32_t r = arc4random()%[alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

@end
