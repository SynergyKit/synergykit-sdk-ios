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

static NSString * const FilterLogicalOr                     = @"or";
static NSString * const FilterLogicalAnd                    = @"and";

static NSString * const FilterRelationEqual                 = @"eq";
static NSString * const FilterRelationNotEqual              = @"ne";
static NSString * const FilterRelationGreaterThan           = @"gt";
static NSString * const FilterRelationGreaterThanOrEqual    = @"ge";
static NSString * const FilterRelationLessThan              = @"lt";
static NSString * const FilterRelationLessThanOrEqual       = @"le";
static NSString * const FilterRelationIn                    = @"in";
static NSString * const FilterRelationNotIn                 = @"nin";

@interface SKODataFilter : NSObject

@property (strong, nonatomic) NSString * field;
@property (strong, nonatomic) id value;
@property (strong, nonatomic) NSString * relationOperator;
@property (strong, nonatomic) NSString * logicalOperator;
@property (strong, nonatomic) NSString * speacialFunction;


-(id)value;
+(NSArray *) correctRelationOperators;

@end
