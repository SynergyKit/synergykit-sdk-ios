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

#ifndef Pods_SBatchableProtocol_h
#define Pods_SBatchableProtocol_h

@class SResponse;
@class SBatchItemWrapper;

@protocol SBatchableProtocol

/**
 *  Creates batch item wrapper that can be added to batch request. Wrapper saves object data to the server.
 *
 *  @param handler Explicit response handler
 *
 *  @return Wrapper that need to be added to SBatch instance for execution.
 */
-(SBatchItemWrapper *) saveInBatch:(void (^)(SResponse *result))handler;

/**
 *  Creates batch item wrapper that can be added to batch request. Wrapper fetches object data from the server.
 *
 *  @param handler Explicit response handler
 *
 *  @return Wrapper that need to be added to SBatch instance for execution.
 */
-(SBatchItemWrapper *) fetchInBatch:(void (^)(SResponse *result))handler;

/**
 *  Created batch item wrapper that can be added to batch request. Wrapper destroys object on the server.
 *
 *  @param handler Explicit response handler
 *
 *  @return Wrapper that need to be added to SBatch instance for execution.
 */
-(SBatchItemWrapper *) destroyInBatch:(void (^)(SResponse *result))handler;

@end

#endif
