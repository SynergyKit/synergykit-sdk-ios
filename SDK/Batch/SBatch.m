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

#import "SBatch.h"
#import "SKSynergy.h"

@implementation SBatch

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItems:(NSMutableArray<SBatchItemWrapper> *)[NSMutableArray new]];
    }
    return self;
}

-(instancetype) addItem:(SBatchItemWrapper *)item
{
    if (item) [self.items addObject:item];
    return self;
}

-(instancetype) addItems:(NSArray<SBatchItemWrapper> *)items
{
    if (items && items.count > 0) [self.items addObjectsFromArray:items];
    return self;
}

-(void) executeWithCompletion:(void (^)(SResponseWrapper *result))completion
{
    [[SKSynergy sharedInstance] batchRequest:self completion:completion];
}

@end
