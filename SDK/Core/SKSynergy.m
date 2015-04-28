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

#import "SKSynergy.h"
#import "AFHTTPRequestOperation.h"
#import "SKHelper.h"
#import "SFile.h"
#import "SIOSocket.h"

static NSString * const TOP_REGEX = @".*\\$top=1(?:\\D.*|$)";

@interface SKSynergy()

@property (nonatomic) BOOL isReady;
@property (nonatomic, retain) NSOperationQueue *operationQueue;
@property (nonatomic, strong) SIOSocket *socket;
@property (nonatomic) BOOL socketIsConnecting;
@property (nonatomic, strong) NSArray *socketConnectingBuffer;
@property (nonatomic, strong) NSMutableArray *observers;

@end

@implementation SKSynergy

@synthesize isReady;
@synthesize tenant;
@synthesize applicationKey;
@synthesize operationQueue;
@synthesize maxConcurrentOperationCount;
@synthesize enableLogging;
@synthesize sessionToken;


#pragma mark
#pragma mark Singleton
#pragma mark

+(id) sharedInstance
{
    static dispatch_once_t once;
    static SKSynergy *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark
#pragma mark Initialization
#pragma mark

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [NSURLCache setSharedURLCache:[SKURLCache sharedURLCache]];
        self.observers = [NSMutableArray new];
        enableLogging = NO;
    }
    return self;
}

#pragma mark
#pragma mark Data
#pragma mark

-(void) createRecord:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!record || !record.collection)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Record or record.collection is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    NSString *urlString = [NSString stringWithFormat:POST_CREATE_RECORD, record.collection];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[record toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:record.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (record.collection && response.result)
            {
                ((SynergykitObject *)response.result).collection = record.collection;
            }
            if (record.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = record.cache;
            }
            completion(response);
        }
    } async:async];
    
}

-(void) record:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!record || !record.collection || !record._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Record, record.collection or record._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:GET_RECORD, record.collection, record._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation;
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:GET cache:record.cache]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:record.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (record.collection && response.result)
            {
                ((SynergykitObject *)response.result).collection = record.collection;
            }
            if (record.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = record.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) updateRecord:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async;
{
    if (!record || !record.collection || !record._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Record, record.collection or record._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:PUT_UPDATE_RECORD, record.collection, record._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:PUT andBody:[record toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:record.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (record.collection && response.result)
            {
                ((SynergykitObject *)response.result).collection = record.collection;
            }
            if (record.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = record.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) deleteRecord:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!record || !record.collection || !record._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Record, record.collection or record._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:DELETE_RECORD, record.collection, record._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:DELETE cache:nil]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return [NSNull new];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark
#pragma mark Data observing
#pragma mark

-(void) startObserving:(SObserver *)o
{
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    if (!o)
    {
        [SKSynergy errorLog:@"Observer is nil."];
        return;
    }
    
    if (self.socketIsConnecting)
    {
        if (self.socketConnectingBuffer)
        {
            NSMutableArray *newA = [NSMutableArray arrayWithArray:self.socketConnectingBuffer];
            [newA addObject:o];
            self.socketConnectingBuffer = [NSArray arrayWithArray:newA];
        }
        else
        {
            self.socketConnectingBuffer = @[o];
        }
    }
    else
    {
        if (!self.socket)
        {
            // Open connection
            self.socketIsConnecting = YES;
            [self openConnection:^{
                [self activateObserver:o enableCallback:YES];
            }];
        }
        else
        {
            [self activateObserver:o enableCallback:YES];
        }
    }
}

-(void) sendSpeak:(SObserver *)observer
{
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    if (!observer.speakName)
    {
        [SKSynergy errorLog:@"Speak name is nil."];
        return;
    }
    
    // Define send speak action
    void (^send)() =  ^void() {
        NSMutableDictionary *argsDict = observer.speakArgs;
        NSArray *subscribeArgs = [[NSArray alloc] initWithObjects:argsDict, nil];
        [self.socket emit:@"speak" args:subscribeArgs];
        [SKSynergy infoLog:[NSString stringWithFormat:@"Emit speak %@.", observer.key]];
    };
    
    if (!self.socket)
    {
        // Open connection
        [self openConnection:^{
            send();
        }];
    }
    else
    {
        send();
    }
}

-(void) stopObserving:(SObserver *)o
{
    if (!o.isValid)
    {
        [SKSynergy errorLog:@"Observer.object, observer.object.collection, observer.event or observer.handler is nil."];
        return;
    }
    
    if (self.socket)
    {
        [self.observers removeObject:o];
        
        if (self.observers.count == 0)
        {
            [self.socket close];
            self.socket = nil;
            // Fake unsubscribe
            if (o.stateHandler) o.stateHandler(SObserverStateUnsubscribed, nil);
            // Fake disconnect
            if (self.observersConnectionDelegate)
            {
                [self.observersConnectionDelegate observingConnectionDidChangeState:SObserverConnectionStateDisconnected];
            }
        }
        
        BOOL containsMoreWithKey = NO;
        for (SObserver *observer in self.observers)
        {
            if ([observer.key isEqualToString:o.key])
            {
                containsMoreWithKey = YES;
                break;
            }
        }
        
        if (!containsMoreWithKey)
        {
            NSMutableDictionary *argsDict = o.subscribeArgs;
            NSArray *unsubscribeArgs = [[NSArray alloc] initWithObjects:argsDict, nil];
            [self.socket emit:@"unsubscribe" args:unsubscribeArgs];
        }
        else
        {
            // Fake unsubscribe
            if (o.stateHandler) o.stateHandler(SObserverStateUnsubscribed, nil);
        }
        
    }
}

-(void) stopAllObservers
{
    if (self.socket)
    {
        [self.socket close];
        self.socket = nil;
        
        // Fake disconnect
        if (self.observersConnectionDelegate)
        {
            [self.observersConnectionDelegate observingConnectionDidChangeState:SObserverConnectionStateDisconnected];
        }
    }
    self.observers = [NSMutableArray new];
}

-(void) openConnection:(void (^) ())completion
{
    NSString *host = SKIT_API;
    
    [SIOSocket socketWithHost:host response:^(SIOSocket *socket)
     {
         [socket on:@"connect" callback:^(NSArray *args)
          {
              if (self.observersConnectionDelegate)
              {
                  [self.observersConnectionDelegate observingConnectionDidChangeState:SObserverConnectionStateConnected];
              }
          }];
         
         [socket on:@"disconnect" callback:^(NSArray *args)
          {
              if (self.observersConnectionDelegate)
              {
                  [self.observersConnectionDelegate observingConnectionDidChangeState:SObserverConnectionStateDisconnected];
              }
          }];
         
         [socket on:@"reconnect" callback:^(NSArray *args)
          {
              if (self.observersConnectionDelegate)
              {
                  [self.observersConnectionDelegate observingConnectionDidChangeState:SObserverConnectionStateReconnected];
              }
              NSArray *observers = [self.observers copy];
              self.observers = [NSMutableArray new];
              for (SObserver *observer in observers)
              {
                  [self activateObserver:observer enableCallback:NO];
              }
          }];
         
         self.socket = socket;
         self.socketIsConnecting = NO;
         
         if (self.socketConnectingBuffer)
         {
             for (SObserver *o in self.socketConnectingBuffer)
             {
                 [self activateObserver:o enableCallback:YES];
             }
             self.socketConnectingBuffer = nil;
         }
         
         // Callback after connection
         completion();
     }];

}

-(void) activateObserver:(SObserver *)o enableCallback:(BOOL)callbackEnabled
{
    if (!o.isValid)
    {
        [SKSynergy errorLog:@"Observer.object, observer.object.collection, observer.event or observer.handler is nil."];
        return;
    }
    
    BOOL alreadyObservingRoom = NO;
    for (SObserver *rObserver in self.observers)
    {
        if ([rObserver.key isEqualToString:o.key])
        {
            alreadyObservingRoom = YES;
            break;
        }
    }
    
    if (callbackEnabled)
    {
        [self.socket on:o.key callback:^(NSArray *args) {
            
            if ([self.observers containsObject:o])
            {
                // Still want to observing
                if (args)
                {
                    NSDictionary *objectDict = (NSDictionary *) args.firstObject;
                    if (o.resultType)
                    {
                        JSONModelError *jError = nil;
                        id object = [SKHelper fromNSDictionaryToObject:objectDict type:o.resultType error:&jError];
                        if (o.objectHandler) o.objectHandler(object);
                    }
                    else
                    {
                        if (o.objectHandler) o.objectHandler(objectDict);
                    }
                }
                else
                {
                    if (o.objectHandler) o.objectHandler(nil);
                }
            }
        }];
        
        [self.socket on:[NSString stringWithFormat:@"subscribed_%@", o.speakName ? o.speakName : o.key] callback:^(NSArray *args) {
            if (o.stateHandler) o.stateHandler(SObserverStateSubscribed, nil);
        }];
        
        [self.socket on:[NSString stringWithFormat:@"unsubscribed_%@", o.speakName ? o.speakName : o.key] callback:^(NSArray *args) {
            if (o.stateHandler) o.stateHandler(SObserverStateUnsubscribed, nil);
        }];
        
        [self.socket on:@"unauthorized" callback:^(NSArray *args) {
            if (o.stateHandler) o.stateHandler(SObserverStateUnauthorized, args);
        }];
    }
    
    if (!alreadyObservingRoom)
    {
        NSMutableDictionary *argsDict = o.subscribeArgs;
        NSArray *subscribeArgs = [[NSArray alloc] initWithObjects:argsDict, nil];
        [self.socket emit:@"subscribe" args:subscribeArgs];
    }
    
    [self.observers addObject:o];
}

#pragma mark
#pragma mark Queries
#pragma mark

-(void) findInEndpoint:(NSString *)endpoint filter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async
{
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [[NSString stringWithFormat:GET_FILTER_BASE, endpoint, filter] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation;
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:GET cache:cache]];
    
    
    NSString *regex = TOP_REGEX;
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regexPredicate evaluateWithObject: filter])
    {
        [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
            JSONModelError *jError = nil;
            return [SKHelper fromNSDictionaryToObject:objectDict type:type error:&jError];
        } completion:completion async:async];
    }
    else
    {
        [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
            return [[type alloc] initWithDictionary:objectDict error:error];
        } completion:completion async:async];
    }
}

-(void) recordIn:(NSString *)collection filter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async
{
    if (!collection)
    {
        if (completion) completion([SKSynergy responseWrapperWithDescription:@"Collection is nil."]);
        return;
    }
    NSString *endpoint = [NSString stringWithFormat:@"/data/%@", collection];
    [self findInEndpoint:endpoint filter:filter resultType:type cache:cache completion:completion async:async];
}

-(void) userWithFilter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async
{
    [self findInEndpoint:@"/users" filter:filter resultType:type cache:cache completion:completion async:async];
}

-(void) fileWithFilter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async
{
    [self findInEndpoint:@"/files" filter:filter resultType:type cache:cache completion:completion async:async];
}

#pragma mark
#pragma mark Users
#pragma mark

-(void) createUser:(SynergykitObject *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!user)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"User is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = POST_CREATE_USER;
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[user toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:user.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (user.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = user.cache;
            }
            
            if (response.succeeded)
            {
                sessionToken = ((SynergykitUser *)response.result).sessionToken;
            }
            
            completion(response);
        }
    } async:async];
}

-(void) user:(SynergykitUser *)user completion:(void (^)(SResponse *result))completion  async:(BOOL)async
{
    if (!user || !user._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"User or user._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:GET_USER, user._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:GET cache:user.cache]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:user.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (user.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = user.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) updateUser:(SynergykitObject *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!user || !user._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"User or user._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:PUT_UPDATE_USER, [user _id]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:PUT andBody:[user toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:user.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (user.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = user.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) deleteUserWithId:(NSString *)userId completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!userId)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"UserId is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:DELETE_USER, userId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:DELETE cache:nil]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return [NSNull new];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark

-(void) addRole:(NSString *)role user:(SynergykitUser *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!role || role.length == 0 || !user || !user._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Role, user or user._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:ADD_ROLE, user._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *jsonBody = [NSString stringWithFormat:@"{\"role\":\"%@\"}", role];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:jsonBody]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:user.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (user.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = user.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) removeRole:(NSString *)role user:(SynergykitUser *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!role || !user || !user._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Role, user or user._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:DELETE_ROLE, user._id, role];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:DELETE cache:nil]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return [NSNull new];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark

-(void) activateUserWithHash:(NSString *)hash completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!hash)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Activation hash is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:ACTIVATE_USER, hash];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:GET cache:nil]];
    
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return nil;
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}
-(void) loginUser:(SynergykitObject *)userObject userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!userObject)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"User couldn't be nil!"]);
        return;
    }
    
    SynergykitUser *user = (SynergykitUser *)userObject;
    
    
    if (!((user.authData.facebook || user.authData.twitter || user.authData.google) || (user.email && user.password)))
    {
        if (completion) completion([SKSynergy responseWithDescription:@"User has no authentication data!"]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = LOGIN_USER;
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[user toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:type error:&jError];
    } completion:^(SResponseWrapper *result) {
        SResponse *response = firstResponseFromWrapper(result);
        if (completion) completion(response);
        if (response.succeeded)
        {
            SynergykitUser *user = response.result;
            sessionToken = user.sessionToken;
        }
    } async:async];
}

#pragma mark
#pragma mark Platforms

-(void) createPlatform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!platform)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Platform is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = ADD_PLATFORM;
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[platform toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:SPlatform.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (platform.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = platform.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) updatePlatform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!platform || !platform._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Platform or platform._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:UPDATE_PLATFORM, platform._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:PUT andBody:[platform toJSONString]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:SPlatform.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (platform.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = platform.cache;
            }
            completion(response);
        }
    } async:async];
}

-(void) deletePlatform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!platform || !platform._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Platform or platform._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:DELETE_PLATFORM, platform._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:DELETE cache:nil]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return [NSNull new];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

-(void) platform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!platform || !platform._id)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Platform or platform._id is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:GET_PLATFORM, platform._id];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation;
    
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:GET cache:platform.cache]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:SPlatform.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion)
        {
            SResponse *response = firstResponseFromWrapper(result);
            if (platform.cache && response.result)
            {
                ((SynergykitObject *)response.result).cache = platform.cache;
            }
            completion(response);
        }
    } async:async];
}

#pragma mark
#pragma mark User & Social
#pragma mark

-(void) userWithFacebookId:(NSString *)userId userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    NSString *filter = [[[[SQuery new] filterField:@"facebook.id" relationOperator:@"==" value:userId] top:1] urlExtension];
    [self userWithFilter:filter resultType:type cache:nil completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

-(void) userWithTwitterId:(NSString *)userId userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    NSString *filter = [[[[SQuery new] filterField:@"twitter.id" relationOperator:@"==" value:userId] top:1] urlExtension];
    [self userWithFilter:filter resultType:type cache:nil completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

-(void) userWithGoogleId:(NSString *)userId userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    NSString *filter = [[[[SQuery new] filterField:@"google.id" relationOperator:@"==" value:userId] top:1] urlExtension];
    [self userWithFilter:filter resultType:type cache:nil completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark
#pragma mark Files
#pragma mark

-(void) fileWithFileId:(NSString *)fileId cache:(SCache *)cache completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!fileId)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"FileId is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:GET_FILE, fileId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation;
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:GET cache:cache]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:SFile.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

-(void) deleteFileWithId:(NSString *)fileId completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!fileId)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"FileId is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:DELETE_FILE, fileId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:DELETE cache:nil]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:[SynergykitObject class] error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

-(void) uploadFile:(NSData *)fileData name:(NSString *)name  mimetype:(NSString *)mimetype completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!fileData || !name || !mimetype)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"FileData, name or mimeType is nil."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"dataName": name};
    
    NSString *urlString = POST_CREATE_FILE;
    
    NSError *e;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:fileData name:name fileName:name  mimeType:mimetype];
    } error:&e];
    
    if (e)
    {
        if (completion) completion([[SResponse alloc] initWithResult:nil error:e]);
    }
    
    [self requestHeaderAuthorization:request];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:SFile.class error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark
#pragma mark Batch
#pragma mark

-(void) batchRequest:(SBatch *)batch completion:(void (^)(SResponseWrapper *result))completion
{
    if (!batch || !batch.items || batch.items.count == 0)
    {
        if (completion) completion([SKSynergy responseWrapperWithDescription:@"Batch doesn't exist or contain any items."]);
        return;
    }

    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = BATCH;
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableString *bodyString = [NSMutableString stringWithString:@"["];
    for (SBatchItemWrapper * item in batch.items)
    {
        [bodyString appendString:[item.item toJSONString]];
        [bodyString appendString:@","];
    }
    NSString *body = [NSString stringWithFormat:@"%@]", [bodyString substringToIndex:[bodyString length]-1]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:body]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *e)
    {
        SBatchItemWrapper *wrapper = ((SBatchItemWrapper *)batch.items[index]);
        
        SBatchResponse *r = [[SBatchResponse.class alloc] initWithDictionary:objectDict error:e];
        if (!r)
        {
            if (wrapper.handler) wrapper.handler([[SResponse alloc] initWithResult:nil error:*e]);
            return nil;
        }
        r.requestItem = wrapper.item;
        Class type = wrapper.type;
        
        id body = [objectDict objectForKey:@"body"];
        if (body && ![body isKindOfClass:NSNull.class] && ![body isEqual:@"null"])
        {
            // Exists response body
            if ([body isKindOfClass:NSDictionary.class])
            {
                // Response body is one object (fetch, save)
                NSDictionary *bodyDict = (NSDictionary *) body;
                if (type && bodyDict.count > 0)
                {
                    r.body = [[type alloc] initWithDictionary:bodyDict error:e];
                    
                    if (!r.body)
                    {
                        if (wrapper.handler) wrapper.handler([[SResponse alloc] initWithResult:nil error:*e]);
                        return nil;
                    }
                    
                    // Put cache and collection to response object from request item
                    id bodyRef = r.body;
                    if ([bodyRef isKindOfClass:SynergykitObject.class])
                    {
                        if (wrapper.item.body.collection)
                        {
                            ((SynergykitObject *)bodyRef).collection = wrapper.item.body.collection;
                        }
                        if (wrapper.item.body.cache)
                        {
                            ((SynergykitObject *)bodyRef).cache = wrapper.item.body.cache;
                        }
                    }
                }
                else
                {
                    r.body = [objectDict objectForKey:@"body"];
                }
            }
            else
            {
                // Response body is array of objects (query)
                NSArray *bodyArray = (NSArray *) body;
                NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:(bodyArray).count];
                
                for (NSDictionary *objectDict in bodyArray)
                {
                    id object = [[type alloc] initWithDictionary:objectDict error:e];
                    if (!object)
                    {
                        if (wrapper.handler) wrapper.handler([[SResponse alloc] initWithResult:nil error:*e]);
                        return nil;
                    }
                    [a addObject:object];
                }
                r.body = a;
            }
        }
        
        if (wrapper.handler) wrapper.handler([[SResponse alloc] initWithResult:r error:nil]);
        return r;
    } completion:completion async:YES];
}

#pragma mark
#pragma mark Communication
#pragma mark

-(void) sendEmailTo:(NSString *)recipient from:(NSString *)sender subject:(NSString *)subject template:(NSString *)templateUrl formVars:(NSDictionary *)variables completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!(recipient && recipient.length > 0) || !(subject && subject.length > 0) || !(templateUrl && templateUrl.length > 0))
    {
        if (completion) completion([SKSynergy responseWithDescription:@"Recipient, subject or templateName is nil or empty."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:SEND_MAIL, templateUrl];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableDictionary *postDict;
    postDict = variables ? [[NSMutableDictionary alloc] initWithDictionary:variables] : [NSMutableDictionary new];
    
    [postDict setObject:recipient forKey:@"email"];
    [postDict setObject:subject forKey:@"subject"];
    
    if (sender) [postDict setObject:sender forKey:@"from"];
    
    NSError *error = nil;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[SKHelper fromNSDictionaryToNSString:postDict error:&error]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return [NSNull new];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

-(void) sendNotificationTo:(NSArray *)userIds alert:(NSString *)alertMessage badge:(NSNumber *)badge payload:(NSString *)jsonPayload sound:(NSString *)sound completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (userIds.count == 0)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"At least one userId is required for notification."]);
        return;
    }
    
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = SEND_NOTIFICATION;
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    
    [postDict setObject:userIds forKey:@"userIds"];
    
    if (alertMessage) [postDict setObject:alertMessage forKey:@"alert"];
    if (jsonPayload) [postDict setObject:jsonPayload forKey:@"payload"];
    if (badge) [postDict setObject:badge forKey:@"badge"];
    if (sound) [postDict setObject:sound forKey:@"sound"];
    
    NSError *error = nil;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[SKHelper fromNSDictionaryToNSString:postDict error:&error]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        return [NSNull new];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark
#pragma mark Cloud Code
#pragma mark

-(void) invokeCloudCode:(NSString *)name resultType:(Class)type codeVars:(NSDictionary *)variables completion:(void (^)(SResponse *result))completion async:(BOOL)async
{
    if (!name)
    {
        if (completion) completion([SKSynergy responseWithDescription:@"CloudCode name couldn't be nil!"]);
        return;
    }
    if (!isReady)
    {
        if (![self makeItReady]) return;
    }
    
    NSString *urlString = [NSString stringWithFormat:POST_CLOUD_CODE, name];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSDictionary *args = [NSDictionary new];
    
    if (variables) args = variables;

    NSError *error = nil;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self requestWithUrl:url andMethod:POST andBody:[SKHelper fromNSDictionaryToNSString:args error:&error]]];
    
    [self executeObjectsOperation:operation deserializer:^id(int index, NSDictionary *objectDict, NSError *__autoreleasing *error) {
        JSONModelError *jError = nil;
        return [SKHelper fromNSDictionaryToObject:objectDict type:type error:&jError];
    } completion:^(SResponseWrapper *result) {
        if (completion) completion(firstResponseFromWrapper(result));
    } async:async];
}

#pragma mark
#pragma mark Connection Helpers
#pragma mark

/**
 *  Prepare Synergy singleton for http communication.
 *
 *  @return YES – singleton is ready; NO – tenant or applicationKey are not set
 */
-(BOOL) makeItReady
{
    if ((tenant == nil || [tenant isEqualToString:@""]) ||
        (applicationKey == nil || [applicationKey isEqualToString:@""]))
    {
        [SKSynergy errorLog:@"Tenant or applicationKey are not set!"];
        return NO;
    }
    
    if (!operationQueue)
    {
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setMaxConcurrentOperationCount:maxConcurrentOperationCount == 0 ? 1 : maxConcurrentOperationCount];
    }
    
    return isReady = YES;
}

-(void) requestHeaderAuthorization:(NSMutableURLRequest *)request
{
    NSString *authorizationString = [NSString stringWithFormat:@"%@:%@", tenant, applicationKey];
    NSData *authorizationData = [authorizationString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authorizatinoBase64 = [authorizationData base64EncodedStringWithOptions:0];
    [request addValue:[NSString stringWithFormat:@"Basic %@", authorizatinoBase64] forHTTPHeaderField:@"Authorization"];
    if (sessionToken) [request addValue:sessionToken forHTTPHeaderField:@"SessionToken"];
}

-(NSMutableURLRequest *) requestWithUrl:(NSURL *)url andMethod:(NSString *)method cache:(SCache *)cache
{
    if (enableLogging) [SKSynergy infoLog: [NSString stringWithFormat:@"%@ %@", method, [url absoluteString]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self requestHeaderAuthorization:request];
    
    if (cache) [self resolveCache:cache withRequest:request];
    
    return request;
}

-(NSMutableURLRequest *) requestWithUrl:(NSURL *)url andMethod:(NSString *)method andBody:(NSString *)json
{
    NSMutableURLRequest *request = [self requestWithUrl:url andMethod:method cache:nil];
    if (json)
    {
        [request setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
        if (enableLogging) [SKSynergy infoLog: [NSString stringWithFormat:@"Request body: %@", json]];
    }
    
    return request;
}

-(void) executeObjectsOperation:(AFHTTPRequestOperation *)operation  deserializer:(id (^)(int index, NSDictionary *objectDict, NSError **error))closure completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async
{
    dispatch_semaphore_t synchronousSemaphore;
    if (!async)
    {
        synchronousSemaphore = dispatch_semaphore_create(0);
        operation.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (enableLogging) [SKSynergy infoLog:[NSString stringWithFormat:@"Response:%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]]];
        if (completion)
        {
            NSError *error = nil;
            id objectArrayOrDict = [SKHelper fromNSDataToFoundationObject:responseObject error:&error];
            
            if (!objectArrayOrDict)
            {
                NSString *dataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if ([dataString isEqualToString:@"null"])
                {
                    // Response is null string
                    completion([[SResponseWrapper alloc] initWithResponse:[[SResponse alloc] initWithResult:nil error:nil]]);
                }
                else if (dataString.length > 0)
                {
                    // Valid string response
                    completion([[SResponseWrapper alloc] initWithResponse:[[SResponse alloc] initWithResult:dataString error:nil]]);
                }
                else
                {
                    completion([SKSynergy responseWrapperWithDescription:@"Deserialization error."]);
                }
                if (synchronousSemaphore) dispatch_semaphore_signal(synchronousSemaphore);
                return;
            }
            
            if ([objectArrayOrDict isKindOfClass:NSDictionary.class])
            {
                NSError *e;
                id object = closure(0, objectArrayOrDict, &e);
                
                completion([[SResponseWrapper alloc] initWithResponse:[[SResponse alloc] initWithResult:object error:e]]);
            }
            else
            {
                NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:((NSArray *)objectArrayOrDict).count];
                int index = 0;
                
                for (NSDictionary *objectDict in objectArrayOrDict)
                {
                    NSError *e;
                    id object = closure(index, objectDict, &e);
                    
                    [a addObject:[[SResponse alloc] initWithResult:object error:e]];
                    
                    index++;
                }
                
                completion([[SResponseWrapper alloc] initWithResponses:a]);
            }
        }
        if (synchronousSemaphore) dispatch_semaphore_signal(synchronousSemaphore);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSMutableString *errorDesc = [[NSMutableString alloc] initWithString:error.userInfo[NSLocalizedDescriptionKey]];
        NSError *deserializationError = nil;
        NSDictionary *response = [SKHelper fromNSDataToNSDictionary:operation.responseObject error:&error];
        if (!deserializationError)
        {
            [errorDesc appendString:@"\n"];
            
            NSString *code = response[@"code"];
            if (code) [errorDesc appendFormat:@"%@", code];
            
            NSString *status = response[@"status"];
            if (status) [errorDesc appendFormat:@" (%@): ", status];
           
            NSString *message = response[@"message"];
            if (message) [errorDesc appendFormat:@"%@", message];
        }
        
        if (completion) completion([SKSynergy responseWrapperWithDescription:errorDesc]);
        if (synchronousSemaphore) dispatch_semaphore_signal(synchronousSemaphore);
    }];
    
    [operationQueue addOperation:operation];
    if (synchronousSemaphore)
    {
        dispatch_semaphore_wait(synchronousSemaphore, DISPATCH_TIME_FOREVER);
    }
}

#pragma mark
#pragma mark Public Helpers
#pragma mark

+(SResponse *) responseWithDescription:(NSString *)description
{
    return [[SResponse alloc] initWithResult:nil error:[SKSynergy errorWithDescription:description]];
}

+(SResponseWrapper *) responseWrapperWithDescription:(NSString *)description
{
    return [[SResponseWrapper alloc] initWithResponse:[SKSynergy responseWithDescription:description]];
}

+(NSError *) errorWithDescription:(NSString *)description
{
    [SKSynergy errorLog:description];
    return [[NSError alloc] initWithDomain:@"Synergykit" code:-1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey, nil]];
}

+(void) errorLog:(NSString *)log
{
#ifdef DEBUG
    if ([[SKSynergy sharedInstance] enableLogging]) NSLog(@"[Synergykit] ERROR: %@", log);
#endif
}

+(void) warningLog:(NSString *)log
{
#ifdef DEBUG
    if ([[SKSynergy sharedInstance] enableLogging]) NSLog(@"[Synergykit] WARNING: %@", log);
#endif
}

+(void) infoLog:(NSString *)log
{
#ifdef DEBUG
    if ([[SKSynergy sharedInstance] enableLogging]) NSLog(@"[Synergykit] INFO: %@", log);
#endif
}

-(void) setMaxConcurrentOperationCount:(int)max
{
    if (!operationQueue)
    {
        operationQueue = [[NSOperationQueue alloc] init];
    }
    [operationQueue setMaxConcurrentOperationCount:max];
}

#pragma mark
#pragma mark Private Helpers
#pragma mark

SResponse* (^firstResponseFromWrapper)(SResponseWrapper *result) = ^(SResponseWrapper *result) {
    SResponse *r = nil;
    if (!result || !result.responses || result.responses.count == 0)
    {
        r = [SKSynergy responseWithDescription:@"Unknown error."];
    }
    else
    {
        r = result.responses[0];
    }
    return r;
};

-(void) resolveCache:(SCache *)cache withRequest:(NSMutableURLRequest *)request
{
    if (cache.expirationInterval > 0)
    {
        [SKCacheManager request:request expirationInterval:cache.expirationInterval];
    }
    
    if (cache.type == SCacheTypeCacheElseLoad)
    {
        // Cache else load
        request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    else if (cache.type == SCacheTypeLoadElseCache)
    {
        // Load else cache
        request.cachePolicy = [SKCacheManager loadElseCache];
    }
    else
    {
        // System cache type
        request.cachePolicy = cache.type;
    }
}



@end
