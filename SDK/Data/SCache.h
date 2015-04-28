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
#import "SCacheType.h"

@interface SCache : NSObject

/**
 *  Determines cache policy
 */
@property (nonatomic) SCacheType type;

/**
 *  Works with @c SCacheTypeLoadElseCache and @c SCacheTypeCacheElseLoad. ExpirationInterval says how old cached data could be.
 */
@property (nonatomic) long expirationInterval;

/**
 *  Initializes object with cache policy.
 *
 *  @param type Determines cache policy.
 *
 *  @return Instance
 */
-(instancetype) initWithType:(SCacheType)type;

/**
 *  Initialized object with cache policy and expiration interval.
 *
 *  @param type    Determines cache policy
 *  @param seconds Determines expiration interval
 *
 *  @return Instance
 */
-(instancetype) initWithType:(SCacheType)type expiration:(long)seconds;

@end
