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
#import "AFHTTPRequestOperationManager.h"
#import "SResponseWrapper.h"
#import "SKRESTHelper.h"
#import "SynergykitUser.h"
#import "SFile.h"
#import "SQuery.h"
#import "SKCacheManager.h"
#import "SBatch.h"
#import "SMethodType.h"
#import "SObserver.h"


@interface SKSynergy : AFHTTPRequestOperationManager

#pragma mark
#pragma mark Singleton
#pragma mark

+(id) sharedInstance;

#pragma mark
#pragma mark Properties
#pragma mark

@property (strong, nonatomic) NSString * tenant;
@property (strong, nonatomic) NSString * applicationKey;
@property (nonatomic) int maxConcurrentOperationCount;
@property (nonatomic) BOOL enableLogging;
@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, assign) id<SObserverConnectionDelegate> observersConnectionDelegate;

#pragma mark
#pragma mark Data
#pragma mark

-(void) createRecord:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) record:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) updateRecord:(SynergykitObject *)record completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) deleteRecord:(SynergykitObject *)recurd completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Data observing
#pragma mark

-(void) startObserving:(SObserver *)o;
-(void) sendSpeak:(SObserver *)o;
-(void) stopObserving:(SObserver *)o;
-(void) stopAllObservers;

#pragma mark
#pragma mark Queries
#pragma mark

-(void) findInEndpoint:(NSString *)endpoint filter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async;
-(void) recordIn:(NSString *)collection filter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async;
-(void) userWithFilter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async;
-(void) fileWithFilter:(NSString *)filter resultType:(Class)type cache:(SCache *)cache completion:(void (^)(SResponseWrapper *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Users
#pragma mark

-(void) createUser:(SynergykitObject *)userObject completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) user:(SynergykitUser *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) updateUser:(SynergykitObject *)userObject completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) deleteUserWithId:(NSString *)userId completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark

-(void) addRole:(NSString *)role user:(SynergykitUser *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) removeRole:(NSString *)role user:(SynergykitUser *)user completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark

-(void) activateUserWithHash:(NSString *)hash completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) loginUser:(SynergykitObject *)userObject userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Platforms

-(void) createPlatform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) platform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) updatePlatform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) deletePlatform:(SPlatform *)platform completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Users & Social
#pragma mark

-(void) userWithFacebookId:(NSString *)userId userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) userWithTwitterId:(NSString *)userId userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) userWithGoogleId:(NSString *)userId userType:(Class)type completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Files
#pragma mark

-(void) uploadFile:(NSData *)file name:(NSString *)name mimetype:(NSString *)mimetype completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) fileWithFileId:(NSString *)fileId cache:(SCache *)cache completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) deleteFileWithId:(NSString *)fileId completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Batch
#pragma mark

-(void) batchRequest:(SBatch *)batch completion:(void (^)(SResponseWrapper *result))completion;

#pragma mark
#pragma mark Communication
#pragma mark

-(void) sendEmailTo:(NSString *)recipient from:(NSString *)sender subject:(NSString *)subject template:(NSString *)templateUrl formVars:(NSDictionary *)variables completion:(void (^)(SResponse *result))completion async:(BOOL)async;
-(void) sendNotificationTo:(NSArray *)userIds alert:(NSString *)alertMessage badge:(NSNumber *)badge payload:(NSString *)jsonPayload sound:(NSString *)sound completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark CloudCode
#pragma mark

-(void) invokeCloudCode:(NSString *)name resultType:(Class)type codeVars:(NSDictionary *)variables completion:(void (^)(SResponse *result))completion async:(BOOL)async;

#pragma mark
#pragma mark Helper methods
#pragma mark

+(SResponse *) responseWithDescription:(NSString *)description;
+(SResponseWrapper *) responseWrapperWithDescription:(NSString *)description;
+(NSError *) errorWithDescription:(NSString *)description;

#pragma mark

+(void) errorLog:(NSString *)log;
+(void) warningLog:(NSString *)log;
+(void) infoLog:(NSString *)log;

#pragma mark

-(void) setMaxConcurrentOperationCount:(int)maxConcurrentOperationCount;

@end
