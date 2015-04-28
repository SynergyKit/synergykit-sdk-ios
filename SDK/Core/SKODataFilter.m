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

#import "SKODataFilter.h"

@implementation SKODataFilter

-(id)value
{
    if ([_value isKindOfClass:[NSString class]])
    {
        // String
        return [NSString stringWithFormat:@"'%@'", _value];
    }
    else if ([_value isKindOfClass:[NSNumber class]])
    {
        Class boolClass = [[NSNumber numberWithBool:YES] class];

        if([_value isKindOfClass:boolClass])
        {
            // BOOL
            return ((NSNumber*)_value).boolValue ? @"true" : @"false";
        }
        else if (strcmp([_value objCType], @encode(int)) == 0)
        {
            // Int
            return [NSString stringWithFormat:@"%@", _value];
        }
        else if (strcmp([_value objCType], @encode(float)) == 0)
        {
            // Float
            return [NSString stringWithFormat:@"%@d", _value];
        }
        else if (strcmp([_value objCType], @encode(double)) == 0)
        {
            // Double
            return [NSString stringWithFormat:@"%@d", _value];
        }
        else
        {
            return [NSString stringWithFormat:@"%@", _value];
        }
    }
    
    return _value;
}

+(NSArray *) correctRelationOperators
{
    return [NSArray arrayWithObjects:FilterRelationEqual, FilterRelationGreaterThan, FilterRelationGreaterThanOrEqual, FilterRelationLessThan, FilterRelationLessThanOrEqual, FilterRelationNotEqual, FilterRelationIn, FilterRelationNotIn, nil];
}

@end
