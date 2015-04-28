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

#import "SKSynergy.h"
#import "SKODataOrderBy.h"
#import "SKODataFilter.h"

@interface SQuery : NSObject <SCacheableProtocol>

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Url extension string that represents inserted conditions.
 */
@property (nonatomic, readonly) NSString *urlExtension;

/**
 *  Filter query string.
 */
@property (nonatomic, readonly) NSString *filterQueryString;

/**
 *  Object that determines where to execute find request (according to collection or type – Data, Users, Files) and how to represent found data (deserialization).
 */
@property (nonatomic, strong) SynergykitObject *object;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes with object that determines return type and find location (by collection or type).
 *
 *  @param object Object that determines return type and find location (by collection or type)
 *
 *  @return Instance
 */
-(instancetype) initWithObject:(SynergykitObject *)object;


#pragma mark
#pragma mark Query builders
#pragma mark

/**
 *  Specifies an expression or function that must evaluate to true for a record to be returned in the collection.
 *
 *  @param field            Field name in database (like _id, name, city, …)
 *  @param relationOperator Relation operator (like ==, !=, … or eq, nq)
 *  @param value            Desired value
 *
 *  @return Instance
 */
-(instancetype) filterField:(NSString *)field relationOperator:(NSString *)relationOperator value:(id)value;


/**
 *  Or logic operator for joining filters.
 *
 *  @return Instance
 */
-(instancetype) filterOr;

/**
 *  And logic operator for joining filters.
 *
 *  @return Instance
 */
-(instancetype) filterAnd;

/**
 *  Speacial filter function that returns records starting with specified value in specified field.
 *
 *  @param field            Field name in database. (example: _id, name, city, …)
 *  @param value            Desired value.
 *
 *  @return Instance
 */
-(instancetype) startsWith:(NSString *)value field:(NSString *)field;

/**
 *  Speacial filter function that returns records that have substring of specified value in specified field.
 *
 *  @param field            Field name in database. (example: _id, name, city, …)
 *  @param value            Desired value.
 *
 *  @return Instance
 */
-(instancetype) substringOf:(NSString *)value field:(NSString *)field;

/**
 *  Speacial filter function that returns records ending with specified value in specified field.
 *
 *  @param field            Field name in database. (example: _id, name, city, …)
 *  @param value            Desired value.
 *
 *  @return Instance
 */
-(instancetype) endsWith:(NSString *)value field:(NSString *)field;

/**
 *  Speacial filter function that returns records that are specified in values.
 *
 *  @param field            Field name in database. (example: _id, name, city, …)
 *  @param string           Comma separated values. (example: Johny, Thomas)
 *
 *  @return Instance
 */
-(instancetype) filterIn:(NSString *)field values:(NSString *)values;

/**
 *  Speacial filter function that returns records that are NOT specified in values.
 *
 *  @param field            Field name in database. (example: _id, name, city, …)
 *  @param string           Comma separated values. (example: Johny, Thomas)
 *
 *  @return Instance
 */
-(instancetype) filterNotIn:(NSString *)field values:(NSString *)values;


/**
 *  Specifies a subset of properties to return and the order in which the columns of data will be organized.
 *
 *  @param string Comma separated fild's names. (example: _id,name,age)
 *  @return Instance
 */
-(instancetype) select:(NSString *)string;


/**
 *  Specifies a maximum number of records to return.
 *
 *  @param numberOfRecords Maximum number of records in response (positive).
 *
 *  @return Instance
 */
-(instancetype) top:(int)numberOfRecords;


/**
 *  Specifies that the response to the request MUST include the count of the number of entities in the collection of entities.
 *
 *  @param enabled YES – MUST include the count.
 *
 *  @return Instance
 */
-(instancetype) inlineCount:(BOOL)enabled;


/**
 *  Specifies the number of records to skip before retrieving records in a collection.
 *
 *  @param skipRecords Number of records to skip (positive).
 *
 *  @return Instance
 */
-(instancetype) skip:(int)skipRecords;


/**
 *  Determines what values are used to order a collection of records.
 *
 *  @param columnName The field to be data sorted by.
 *  @param direction  Sort direction.
 *
 *  @return Instance
 */
-(instancetype) orderBy:(NSString *)field direction:(OrderByDirectionType)direction;

#pragma mark
#pragma mark Instance methods
#pragma mark

/**
 *  Finds object data on the server according query @em synchronously.
 *
 *  @attention Every @c SResponse in returned wrapper contains result object (querying with @c top(1)) or @b array of objects (querying without @c top(1)).
 *
 *  @return @c SResponseWrapper object after completion
 */
-(SResponseWrapper *) find;

/**
 *  Finds object data on the server according query @em asynchronously.
 *
 *   *  @attention Every @c SResponse in result wrapper contains result object (querying with @c top(1)) or @b array of objects (querying without @c top(1)).
 *
 *  @param handler Callback of function
 */
-(void) find:(void (^)(SResponseWrapper *result))handler;

/**
 *  Finds object data on the server according query @em asynchronously.
 *
 *  @param handler Explicit response handler
 *
 *  @return Wrapper that need to be added to SBatch instance for execution.
 */
-(SBatchItemWrapper *) findInBatch:(void (^)(SResponse *result))handler;

@end
