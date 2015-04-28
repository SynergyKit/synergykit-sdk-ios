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

@interface Synergykit : NSObject

#pragma mark
#pragma mark Static methods
#pragma mark

/**
 *  Synergykit SDK initilizer.
 *
 *  @param tenant Application url @em (Settings > Application keys > Tenant)
 *  @param key    Application key (Settings > Application keys > Value)
 *
 */
+(void) setTenant:(NSString *)tenant key:(NSString *)key;

/**
 *  Enables logging to Console.
 *
 *  @param debug YES – enable; NO – disable
 */
+(void) enableDebugging:(BOOL)debug;

@end
