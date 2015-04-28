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

#import "SQuery.h"

static NSString * const FILTER = @"&$filter=";
static NSString * const SELECT = @"&$select=";
static NSString * const TOP = @"&$top=";
static NSString * const INLINE_COUNT = @"&$inlinecount=";
static NSString * const SKIP = @"&$skip=";
static NSString * const ORDER_BY = @"&$orderby=";

@implementation SQuery
{
    NSString *select;
    NSMutableArray<SKODataOrderBy> *orderByArray;
    NSMutableArray *filterArray;
    int top, skip;
    OrderByDirectionType orderByDirection;
    BOOL inlineCount;
    BOOL isInlineCountSet, unassignLogicOperator, isSpeacialFilterType;
}

@synthesize cache;
@synthesize object;

#pragma mark
#pragma mark Initialization
#pragma mark

-(instancetype) init
{
    self = [super init];
    if (self)
    {
        select = @"";
        orderByArray = (NSMutableArray<SKODataOrderBy> *)[[NSMutableArray alloc] init];
        filterArray = [[NSMutableArray alloc] init];
        top = 0;
        skip = 0;
        orderByDirection = OrderByDirectionAsc;
    }
    return self;
}

-(instancetype)initWithObject:(SynergykitObject *)o
{
    self = [self init];
    if (self)
    {
        [self setObject:o];
    }
    return self;
}

#pragma mark
#pragma mark SCacheableProtocol
#pragma mark

-(instancetype)cache:(SCache *)nCache
{
    if (nCache) [self setCache:nCache];
    return self;
}

#pragma mark
#pragma mark Filters
#pragma mark

-(instancetype) filterField:(NSString *)field relationOperator:(NSString *)relationOperator value:(id)value
{
    if (isSpeacialFilterType)
    {
        [[SKSynergy sharedInstance] warningLog:@"Bad filter structure. You can't use speacial filter action (in, not in, starts with, …) with normal action (field eq value)."];
        return self;
    }
    
    SKODataFilter *filterObject;
    if (unassignLogicOperator)
    {
        filterObject = [filterArray lastObject];
    }
    else
    {
        filterObject = [[SKODataFilter alloc] init];
    }
    filterObject.field = field;
    filterObject.relationOperator = relationOperator;
    filterObject.value = value;
    
    if (!unassignLogicOperator)
    {
        [filterArray addObject:filterObject];
    }
    else
    {
        unassignLogicOperator = NO;
    }
    return self;
}

-(instancetype) filterOr
{
    if (isSpeacialFilterType)
    {
        [[SKSynergy sharedInstance] warningLog:@"Bad filter structure. You can't use speacial filter action (in, not in, starts with, …) with normal action (field eq value)."];
        return self;
    }
    
    SKODataFilter *filterObject;
    if (unassignLogicOperator)
    {
        filterObject = [filterArray lastObject];
    }
    else
    {
        filterObject = [[SKODataFilter alloc] init];
        unassignLogicOperator = YES;
    }
    filterObject.logicalOperator = FilterLogicalOr;
    
    [filterArray addObject:filterObject];
    return self;
}
-(instancetype) filterAnd
{
    if (isSpeacialFilterType)
    {
        [[SKSynergy sharedInstance] warningLog:@"Bad filter structure. You can't use speacial filter action (in, not in, starts with, …) with normal action (field eq value)."];
        return self;
    }
    
    SKODataFilter *filterObject;
    if (unassignLogicOperator)
    {
        filterObject = [filterArray lastObject];
    }
    else
    {
        filterObject = [[SKODataFilter alloc] init];
        unassignLogicOperator = YES;
    }
    filterObject.logicalOperator = FilterLogicalAnd;
    
    [filterArray addObject:filterObject];
    return self;
}

-(instancetype) startsWith:(NSString *)value field:(NSString *)field
{
    SKODataFilter *filterObject = [[SKODataFilter alloc] init];
    
    filterObject.field = field;
    filterObject.speacialFunction = @"startswith";
    filterObject.value = value;
    
    filterArray = [NSMutableArray arrayWithObject:filterObject];
    unassignLogicOperator = NO;
    isSpeacialFilterType = YES;
    
    return self;
}

-(instancetype) substringOf:(NSString *)value field:(NSString *)field
{
    SKODataFilter *filterObject = [[SKODataFilter alloc] init];
    
    filterObject.field = field;
    filterObject.speacialFunction = @"substringof";
    filterObject.value = value;
    
    filterArray = [NSMutableArray arrayWithObject:filterObject];
    unassignLogicOperator = NO;
    isSpeacialFilterType = YES;
    
    return self;
}

-(instancetype) endsWith:(NSString *)value field:(NSString *)field
{
    SKODataFilter *filterObject = [[SKODataFilter alloc] init];
    
    filterObject.field = field;
    filterObject.speacialFunction = @"endswith";
    filterObject.value = value;
    
    filterArray = [NSMutableArray arrayWithObject:filterObject];
    unassignLogicOperator = NO;
    isSpeacialFilterType = YES;
    
    return self;
}

-(instancetype) filterIn:(NSString *)field values:(NSString *)values
{
    SKODataFilter *filterObject = [[SKODataFilter alloc] init];
    
    filterObject.field = field;
    filterObject.relationOperator = @"in";
    filterObject.value = values;
    
    filterArray = [NSMutableArray arrayWithObject:filterObject];
    unassignLogicOperator = NO;
    isSpeacialFilterType = YES;
    
    return self;
}

-(instancetype) filterNotIn:(NSString *)field values:(NSString *)values
{
    SKODataFilter *filterObject = [[SKODataFilter alloc] init];
    
    filterObject.field = field;
    filterObject.relationOperator = @"nin";
    filterObject.value = values;
    
    filterArray = [NSMutableArray arrayWithObject:filterObject];
    unassignLogicOperator = NO;
    isSpeacialFilterType = YES;
    
    return self;
}

#pragma mark
#pragma mark Special filters
#pragma mark

-(instancetype) select:(NSString *)string
{
    select = string;
    return self;
}

-(instancetype) top:(int)numberOfRecords
{
    top = numberOfRecords;
    return self;
}

-(instancetype) inlineCount:(BOOL)enabled
{
    isInlineCountSet = YES;
    inlineCount = enabled;
    return self;
}

-(instancetype) skip:(int)skipRecords
{
    skip = skipRecords;
    return self;
}

-(instancetype) orderBy:(NSString *)field direction:(OrderByDirectionType)direction;
{
    SKODataOrderBy *orderBy = [[SKODataOrderBy alloc] init];
    orderBy.field = field;
    orderBy.direction = direction;
    
    [orderByArray addObject:orderBy];
    
    return self;
}

#pragma mark
#pragma mark String builders
#pragma mark

-(NSString *)urlExtension
{
    NSMutableString *urlExtension = [NSMutableString new];
    
    if (top != 0)
    {
        if ([self validateTop]) [urlExtension appendString:[NSString stringWithFormat:@"%@%d", TOP, top]];
    }
    
    if ([orderByArray count]  != 0)
    {
        if ([self validateOrderBy]) [urlExtension appendString:[self orderByString]];
    }
    
    
    if (isInlineCountSet)
    {
        [urlExtension appendString:[NSString stringWithFormat:@"%@%@", INLINE_COUNT, inlineCount ? @"allpages" : @"none"]];
    }
    
    if (skip != 0)
    {
        if ([self validateSkip]) [urlExtension appendString:[NSString stringWithFormat:@"%@%d", SKIP, skip]];
    }
    
    if (![select isEqualToString:@""])
    {
        if ([self validateSelect]) [urlExtension appendString:[NSString stringWithFormat:@"%@%@", SELECT, [select stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    }
    
    [urlExtension appendString:[self filterQueryString]];
    
    if (urlExtension.length == 0)
    {
        return @"";
    }
    
    NSRange firstAnd = [urlExtension rangeOfString:@"&"];
    if (NSNotFound != firstAnd.location) {
        urlExtension = (NSMutableString *)[urlExtension stringByReplacingCharactersInRange:firstAnd withString:@"?"];
    }
    
    return [NSString stringWithString:[urlExtension stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
}

-(NSString *)filterQueryString
{
    if (![self validateFilter]) return @"";
    
    NSMutableString *filterString = [NSMutableString new];
    
    for (SKODataFilter *filterObject in filterArray)
    {
        if (filterObject.speacialFunction)
        {
            [filterString appendString:[NSString stringWithFormat:@"%@('%@',%@)", filterObject.speacialFunction, filterObject.field, filterObject.value]];
        }
        else if (filterObject.logicalOperator == nil)
        {
            [filterString appendString:[NSString stringWithFormat:@"'%@' %@ %@", filterObject.field, filterObject.relationOperator, filterObject.value]];
        }
        else
        {
            [filterString appendString:[NSString stringWithFormat:@" %@ '%@' %@ %@", filterObject.logicalOperator, filterObject.field, filterObject.relationOperator, filterObject.value]];
        }
    }
    return filterString;
}

-(NSString *) orderByString
{
    NSMutableString *orderByString = [NSMutableString stringWithFormat:@"%@", ORDER_BY];
    
    for (SKODataOrderBy *orderBy in orderByArray)
    {
        [orderByString appendString:[NSString stringWithFormat:@"%@ %@,", orderBy.field, orderBy.direction == OrderByDirectionAsc ? @"asc" : @"desc"]];
    }
    
    return [NSString stringWithFormat:@"%@", [orderByString substringToIndex:[orderByString length]-1]];
}

#pragma mark
#pragma mark Validation
#pragma mark

-(BOOL) validateTop
{
    if (top < 0)
    {
        [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid top value: ›%d‹", top]];
        return NO;
    }
    return YES;
}

-(BOOL) validateOrderBy
{
    if ([orderByArray count] > 12)
    {
        [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! You can select up to 12 columns using orderby (%lu selected).", (unsigned long)[orderByArray count]]];
        return NO;
    }
    
    for (SKODataOrderBy *orderBy in orderByArray)
    {
        if (![self validateField:orderBy.field])
        {
            [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid orderby value: ›%@‹", orderBy.field]];
            return NO;
        }
    }
    
    return YES;
}

-(BOOL) validateSkip
{
    if (skip < 0)
    {
        [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid skip value: ›%d‹", skip]];
        return NO;
    }
    return YES;
}

-(BOOL) validateSelect
{
    for (NSString *s in [select componentsSeparatedByString:@","])
    {
        NSString *trim = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (![self validateField:trim])
        {
            [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid select field with value: ›%@‹", trim]];
            return NO;
        }
    }
    
   return YES;
}

-(BOOL) validateFilter
{
    int index = 0;
    for (SKODataFilter *filterObject in filterArray)
    {
        if (![self validateField:filterObject.field])
        {
            [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid filter field: ›%@‹", filterObject.field]];
            return NO;
        }
        if (filterObject.speacialFunction)
        {
            // Speacial functions (startswith, endswith, substringof) contain only field and value
            return YES;
        }
        if (![self validateRelationOperator:filterObject])
        {
            [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid filter relation operator: ›%@‹", filterObject.relationOperator]];
            return NO;
        }
        if (index > 0 && filterObject.logicalOperator == nil)
        {
            [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"Validation Error! Invalid filter logical operator for field: ›%@‹", filterObject.field]];
            return NO;
        }
        index++;
    }
    return YES;
}

-(BOOL) validateField:(NSString *)field
{
    NSString *regex = @"^[_a-zA-Z0-9\\.]*$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regexPredicate evaluateWithObject:field];
}

-(BOOL) validateRelationOperator:(SKODataFilter *)filterObject
{
    for (NSString *operator in [SKODataFilter correctRelationOperators])
    {
        if ([filterObject.relationOperator isEqualToString:operator]) return YES;
    }
    
    if ([filterObject.relationOperator isEqualToString:@"=="])
    {
        filterObject.relationOperator = FilterRelationEqual;
        return YES;
    }
    else if ([filterObject.relationOperator isEqualToString:@"!="])
    {
        filterObject.relationOperator = FilterRelationNotEqual;
        return YES;
    }
    else if ([filterObject.relationOperator isEqualToString:@">"])
    {
        filterObject.relationOperator = FilterRelationGreaterThan;
        return YES;
    }
    else if ([filterObject.relationOperator isEqualToString:@">="])
    {
        filterObject.relationOperator = FilterRelationGreaterThanOrEqual;
        return YES;
    }
    else if ([filterObject.relationOperator isEqualToString:@"<"])
    {
        filterObject.relationOperator = FilterRelationLessThan;
        return YES;
    }
    else if ([filterObject.relationOperator isEqualToString:@"<="])
    {
        filterObject.relationOperator = FilterRelationLessThanOrEqual;
        return YES;
    }
    
    return NO;
}

#pragma mark
#pragma mark - Find
#pragma mark

-(SResponseWrapper *) find
{
    if (!object)
    {
        return [SKSynergy responseWrapperWithDescription:@"Object is nil."];
    }
    
    NSMutableString *endpoint = [NSMutableString new];
    [endpoint appendString:object.endpoint];
    
    if ([object.endpoint rangeOfString:@"/data"].location != NSNotFound)
    {
        // Record must contain collection
        if (!object.collection)
        {
            return [SKSynergy responseWrapperWithDescription:@"Object.collection is nil."];
        }
        
        [endpoint appendString:@"/"];
        [endpoint appendString:object.collection];
    }
    
    __block SResponseWrapper *response = nil;
    
    [[SKSynergy sharedInstance] findInEndpoint:endpoint filter:[self urlExtension] resultType:object.class cache:self.cache completion:^(SResponseWrapper *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void) find:(void (^)(SResponseWrapper *result))handler;
{
    if (!object)
    {
        handler([SKSynergy responseWrapperWithDescription:@"Object is nil."]);
        return;
    }
    
    NSMutableString *endpoint = [NSMutableString new];
    [endpoint appendString:object.endpoint];
    
    if ([object.endpoint rangeOfString:@"/data"].location != NSNotFound)
    {
        // Record must contain collection
        if (!object.collection)
        {
            handler([SKSynergy responseWrapperWithDescription:@"Object.collection is nil."]);
            return;
        }
        
        [endpoint appendString:@"/"];
        [endpoint appendString:object.collection];
    }
    
    [[SKSynergy sharedInstance] findInEndpoint:endpoint filter:[self urlExtension] resultType:object.class cache:self.cache completion:handler async:YES];
}

-(SBatchItemWrapper *) findInBatch:(void (^)(SResponse *result))handler
{
    if (!object)
    {
        handler([SKSynergy responseWithDescription:@"Object is nil."]);
        return nil;
    }
    
    NSMutableString *endpoint = [NSMutableString new];
    [endpoint appendString:object.endpoint];
    
    if ([object.endpoint rangeOfString:@"/data"].location != NSNotFound)
    {
        // Record must contain collection
        if (!object.collection)
        {
            handler([SKSynergy responseWithDescription:@"Object.collection is nil."]);
            return nil;
        }
        
        [endpoint appendString:@"/"];
        [endpoint appendString:object.collection];
    }
    
    NSString *batchEndpoint = [[NSString stringWithFormat:@"%@%@", endpoint, self.urlExtension] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeGET endpoint:batchEndpoint body:nil];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:object.class handler:handler];
    return wrapper;
}

@end
