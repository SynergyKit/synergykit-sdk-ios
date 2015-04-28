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
#import <UIKit/UIKit.h>

@interface SFile : SynergykitObject

#pragma mark
#pragma mark Properties
#pragma mark

/**
 *  URI where file is located.
 */
@property (nonatomic, strong) NSString * path;

/**
 *  Extension of the file.
 */
@property (nonatomic, strong) NSString * extension;

/**
 *  Unique name of file.
 */
@property (nonatomic, strong) NSString * filename;

/**
 *  URL of your application.
 */
@property (nonatomic, strong) NSString * applicationUrl;

/**
 *  Size of file in bytes.
 */
@property (nonatomic, strong) NSNumber * size;

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

#pragma mark
#pragma mark Uploads with predefined type
#pragma mark

/**
 *  Uploads JPEG file on the server.
 *
 *  @param imageData NSData representing image. For conversions UIImage —› NSData uses UIImageJPEGRepresentation.
 *  @param handler   Callback of function
 */
-(void) uploadJPEGImage:(NSData *)imageData handler:(void (^)(SResponse *result))handler;

/**
 *  Uploads PNG file on the server.
 *
 *  @param imageData NSData representing image. For conversions UIImage —› NSData uses UIImagePNGRepresentation.
 *  @param handler   Callback of function
 */
-(void) uploadPNGImage:(NSData *)imageData handler:(void (^)(SResponse *result))handler;

/**
 *  Uploads GIF file on the server.
 *
 *  @param imageData NSData representing image.
 *  @param handler   Callback of function
 */
-(void) uploadGIFImage:(NSData *)imageData handler:(void (^)(SResponse *result))handler;

/**
 *  Uploads MOV file on the server.
 *
 *  @param imageData NSData representing image.
 *  @param handler   Callback of function
 */
-(void) uploadMovie:(NSData *)movData handler:(void (^)(SResponse *result))handler;

#pragma mark
#pragma mark Universal upload
#pragma mark

/**
 *  Uploads data on the server.
 *
 *  @param data      NSData representing data object
 *  @param mimetype  mimeType of the object
 *  @param extension Extenstion of the file
 *  @param handler   Callback of function
 */
-(void) upload:(NSData *)data mimetype:(NSString *)mimetype extension:(NSString *)extension handler:(void (^)(SResponse *result))handler;

/**
 *  Uploads file from assets library according to URL.
 *
 *  @param url     NSURL of object in library
 *  @param handler Callback of function
 */
-(void) uploadFromAssetsLibrary:(NSURL *)url handler:(void (^)(SResponse *result))handler;

/**
 *  Uploads file from URL.
 *
 *  @param url     NSURL of object
 *  @param handler Callback of function
 */
-(void) uploadFileOnURL:(NSURL *)url handler:(void (^)(SResponse *result))handler;

/**
 *  Uploads file from path in bundle.
 *
 *  @param path    Path to file in bundle
 *  @param handler Completion handler
 */
-(void) uploadFileOnPath:(NSString *)path handler:(void (^)(SResponse *result))handler;

@end