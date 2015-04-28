//
//  CloudCodeDemo.h
//  sampleapp
//
//  Created by Jan Čislinský on 15/01/15.
//  Copyright (c) 2015 Letsgood.com s.r.o. All rights reserved.
//

#import "SynergykitObject.h"

@interface CloudCodeDemo : SynergykitObject

@property (nonatomic, retain) NSString<Optional> * error;
@property (nonatomic, retain) NSString<Optional> * path;

@property (nonatomic, retain) NSNumber<Optional> * age;
@property (nonatomic, retain) NSNumber<Optional> * ageRange;
@property (nonatomic, retain) NSString<Optional> * race;
@property (nonatomic, retain) NSNumber<Optional> * raceConfidence;
@property (nonatomic, retain) NSString<Optional> * gender;
@property (nonatomic, retain) NSNumber<Optional> * genderConfidence;
@property (nonatomic, retain) NSNumber<Optional> * smiling;
@property (nonatomic, retain) NSString<Optional> * glass;
@property (nonatomic, retain) NSNumber<Optional> * glassConfidence;
@property (nonatomic, retain) NSString<Optional> * name;

@end
