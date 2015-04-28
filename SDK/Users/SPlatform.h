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

#import "SynergykitObject.h"

@class SynergykitUser;

/**
 *  Platform represents every user's device. It enables to send notification to every device of the user.
 */
@interface SPlatform : SynergykitObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  Name of the platform. (apple is default)
 */
@property (nonatomic, retain) NSString<Optional> * platformName;

/**
 *  Device identificator. REQUIRED for notification.
 */
@property (nonatomic, retain) NSString<Optional> * registrationId;

/**
 *  True if user want to receive notification with development certificates. False for pruduction certificates.
 */
@property (nonatomic, retain) NSNumber<Optional> * development;

#pragma mark
#pragma mark Initialization
#pragma mark

/**
 *  Initializes object with object._id. After this init you can call @b object.fetch().
 *
 *  @param id        API identificator
 *
 *  @return Instance
 */
-(instancetype) initWithId:(NSString *)_id;

@end