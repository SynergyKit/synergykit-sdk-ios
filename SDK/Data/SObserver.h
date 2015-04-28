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
#import "SMethodType.h"
#import "SObserverConnectionState.h"
#import "SObserverState.h"
#import "SObserverConnectionDelegate.h"

@class SynergykitObject;
@class SQuery;

@interface SObserver : NSObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Required! Handler that is triggered on change in collection.
 */
@property (nonatomic, strong, readonly) void (^objectHandler)(id result);

/**
 *  Optional! Handler that handles observer subscription state. Handlar is fired after @c starObserving… call with @c Subscribed state or @c Unauthorized state if there is a problem with authorization. Handler is also fired after @c stopObserving call with @c Unsubscribed state.
 */
@property (nonatomic, strong, readonly) void (^stateHandler)(SObserverState state, NSArray *errors);

/**
 *  Required! Event name for communication with API.
 */
@property (nonatomic, readonly) NSString *event;

/**
 *  Required! Collection where changes are observed.
 */
@property (nonatomic, readonly) NSString *collection;

/**
 *  Optional! Filter that refines observed location.
 */
@property (nonatomic, readonly) NSString *filter;

/**
 *  Name of query filter if it's used.
 */
@property (nonatomic, strong) NSString *filterName;

/**
 *  Label for communication from @b device-to-device @e without data store on api.
 */
@property (nonatomic, strong) NSString *speakName;

/**
 *  Optional! Data type of result data.
 */
@property (nonatomic, strong) Class resultType;

/**
 *  API handshake arguments getter.
 */
@property (nonatomic, readonly) NSMutableDictionary *subscribeArgs;

/**
 *  API handshake arguments getter.
 */
@property (nonatomic, readonly) NSMutableDictionary *speakArgs;

/**
 *  API idetificator of collection, event and filter in format event_collection[_filterName] or identificator of speak.
 */
@property (nonatomic, readonly) NSString *key;

/**
 *  Unique identificator of observer (app side).
 */
@property (nonatomic, readonly) NSString *_id;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes object with @c SynergykitObject that determines result type and collection and event.
 *
 *  @attention Use this initializer if you want to observer data collection @b without filter.
 *
 *  @param o Object that determines observed collection and result type.
 *  @param e Event name for communication with API.
 *
 *  @return Instance
 */
-(instancetype) initWithObject:(SynergykitObject *)o event:(SMethodType)e;

/**
 *  Initializes object with @c SQuery that determines result type, collection and filter query and filterName and event.
 *
 *  @attention Use this initializer if you want to observe data collection @b with filter.
 *
 *  @param o    Object that determines result type, collection adn filter query.
 *  @param name Name of filter.
 *  @param e    Event name for communication with API.
 *
 *  @return Instance
 */
-(instancetype) initWithObject:(SQuery *)o queryName:(NSString *)name event:(SMethodType)e;

/**
 *  Initializes object with @b speakName for @b device-to-device communication without data store on api. After this initializer you can call @c speakWithObject: method.
 *
 *  @param speak Label for communication from @b device-to-device @e without data store on api.
 *
 *  @return Instance
 */
-(instancetype) initWithSpeakName:(NSString *)speak;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Starts observing data changes in collection.
 *
 *  @param handler Handler that is triggered on observed event in collection.
 *
 *  @return Observer instance
 */

/**
 *  Starts observing data changes in collection.
 *
 *  @param objectHandler Handler that is triggered on change in collection.
 *  @param stateHandler  Handler that is triggered on observer state change.
 *
 *  @return Instance
 */
-(instancetype) startObservingWithObjectHandler:(void (^)(id result))objectHandler stateHandler:(void (^)(SObserverState state, NSArray *errors))stateHandler;

/**
 *  Send speak to devices that are observing speakName.
 *
 *  @param o Optional! Object that will be send with speak.
 *
 *  @return Instance
 */
-(instancetype) speakWithObject:(id)o;

/**
 *  Ends observing data changes of observer.
 */
-(void) stopObserving;

/**
 *  Determined that observer contains of all mandatory informations.
 *
 *  @return YES – contains all mandatory informations
 */
-(BOOL) isValid;

#pragma mark
#pragma mark Static methods
#pragma mark

/**
 *  Ends observing all observers and close connection.
 */
+(void) stopAllObservers;

/**
 *  Set connection delegate that handles connection events.
 */
+(void) connectionDelegate:(id<SObserverConnectionDelegate>)delegate;

/**
 *  Get connection delegate that handles connection events.
 */
+(id<SObserverConnectionDelegate>) connectionDelegate;

@end
