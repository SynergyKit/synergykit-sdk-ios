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

#import "Synergykit.h"
#import "SKSynergy.h"

@implementation Synergykit

+(void) setTenant:(NSString *)tenant key:(NSString *)key
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    if (tenant && key)
    {
        skit.tenant = tenant;
        skit.applicationKey = key;
    }
    else
    {
        [SKSynergy warningLog:@"Tenant and key couldn't be null."];
    }
}

+(void) enableDebugging:(BOOL)debug
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    skit.enableLogging = debug;
}

@end
