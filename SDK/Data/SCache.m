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

#import "SCache.h"

@implementation SCache

-(instancetype)init
{
    return [self initWithType:SCacheTypeSystemUseProtocolCachePolicy expiration:-1];
}

-(instancetype) initWithType:(SCacheType)type
{
    return [self initWithType:type expiration:-1];
}

-(instancetype) initWithType:(SCacheType)type expiration:(long)seconds
{
    self = [super init];
    if (self)
    {
        [self setType:type];
        [self setExpirationInterval:seconds];
    }
    return self;
}

@end