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

#import "SFile.h"
#import "SKSynergy.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation SFile

@synthesize endpoint = _endpoint;

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _endpoint = @"/files";
    }
    return self;
}

-(instancetype) initWithId:(NSString *)n_id
{
    self = [self init];
    if (self)
    {
        [self set_id:n_id];
    }
    return self;
}

#pragma mark
#pragma mark Synergy Protocol
#pragma mark

-(SResponse *)save
{
    [[SKSynergy sharedInstance] warningLog:@"[SFile save] is not allowed. You can't create or update SFile object this way. Create SFile with some of upload method."];
    return nil;
}

-(void)save:(void (^)(SResponse *result))handler
{
    handler([SKSynergy responseWithDescription:@"[SFile save] is not allowed. You can't create or update SFile object this way. Create SFile with some of upload method."]);
}

-(SBatchItemWrapper *)saveInBatch:(void (^)(SResponse *result))handler
{
    [SKSynergy errorLog:@"[SFile saveInBatch] is not allowed. You can't create or update SFile object this way. Create SFile with some of upload method."];
    return nil;
}

-(SResponse *)fetch
{
    __block SResponse *response;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit fileWithFileId:self._id cache:self.cache completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void)fetch:(void (^)(SResponse *result))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit fileWithFileId:self._id cache:self.cache completion:handler async:YES];
}

-(SBatchItemWrapper *)fetchInBatch:(void (^)(SResponse *result))handler
{
    if (!self._id || ![[SKSynergy sharedInstance] tenant])
    {
        [[SKSynergy sharedInstance] errorLog:@"_id or tenant is nil."];
        return nil;
    }
    
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/file/%@", self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeGET endpoint:batchEndpoint body:self];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

-(SResponse *)destroy
{
    __block SResponse *response;
    
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit deleteFileWithId:self._id completion:^(SResponse *result) {
        response = result;
    } async:NO];
    
    return response;
}

-(void)destroy:(void (^)(SResponse *))handler
{
    SKSynergy *skit = [SKSynergy sharedInstance];
    [skit deleteFileWithId:self._id completion:handler async:YES];
}

-(SBatchItemWrapper *)destroyInBatch:(void (^)(SResponse *result))handler
{
    if (!self._id || ![[SKSynergy sharedInstance] tenant])
    {
        [SKSynergy errorLog:@"_id or tenant is nil."];
        return nil;
    }
    
    NSString *batchEndpoint = [NSString stringWithFormat:@"/file/%@", self._id];
    SBatchItem *item = [[SBatchItem alloc] initWithId:[NSNumber numberWithInt:-1] method:SMethodTypeDELETE endpoint:batchEndpoint body:nil];
    
    SBatchItemWrapper *wrapper = [[SBatchItemWrapper alloc] initWithItem:item type:self.class handler:handler];
    return wrapper;
}

#pragma mark

-(void) uploadJPEGImage:(NSData *)data handler:(void (^)(SResponse *result))handler
{
    [self upload:data mimetype:@"image/jpeg" extension:@"jpg" handler:handler];
}

-(void) uploadPNGImage:(NSData *)data handler:(void (^)(SResponse *result))handler
{
    [self upload:data mimetype:@"image/png" extension:@"png" handler:handler];
}

-(void) uploadGIFImage:(NSData *)data handler:(void (^)(SResponse *result))handler
{
    [self upload:data mimetype:@"image/gif" extension:@"gif" handler:handler];
}

-(void) uploadMovie:(NSData *)data handler:(void (^)(SResponse *result))handler
{
    [self upload:data mimetype:@"video/quicktime" extension:@"mov" handler:handler];
}

-(void) upload:(NSData *)data mimetype:(NSString *)mimetype extension:(NSString *)extension handler:(void (^)(SResponse *result))handler
{
    if (data && (extension && extension.length > 0) && (mimetype && mimetype.length > 0))
    {
        [[SKSynergy sharedInstance] uploadFile:data name:[NSString stringWithFormat:@"file.%@", extension] mimetype:mimetype completion:handler async:YES];
    }
    else
    {
        handler([SKSynergy responseWithDescription:@"File data is nil."]);
    }
}

-(void) uploadFromAssetsLibrary:(NSURL *)url handler:(void (^)(SResponse *result))handler
{
    if (url)
    {
        if ([url.absoluteString containsString:@"file:///"])
        {
            [self uploadFileOnURL:url handler:handler];
            return;
        }
        
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        
        [assetslibrary assetForURL:url resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
            NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:(unsigned int)rep.size error:nil];
            NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
            
            [self recognizeMimetype:data extenstion:url.pathExtension handler:handler];
            
        } failureBlock:^(NSError *error) {
            handler([[SResponse alloc] initWithResult:nil error:error]);
        }];
    }
    else
    {
        handler([SKSynergy responseWithDescription:@"NSURL to asset file is nil."]);
    }
}

-(void) uploadFileOnURL:(NSURL *)url handler:(void (^)(SResponse *result))handler
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [self recognizeMimetype:data extenstion:url.pathExtension handler:handler];
}

-(void) uploadFileOnPath:(NSString *)path handler:(void (^)(SResponse *result))handler
{
    NSURL *url = [[NSURL alloc] initWithString:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [self recognizeMimetype:data extenstion:url.pathExtension handler:handler];
}

-(void) recognizeMimetype:(NSData *)data extenstion:(NSString *)extenstion handler:(void (^)(SResponse *result))handler
{
    if ([extenstion caseInsensitiveCompare:@"jpg"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"image/jpeg" extension:@"jpg" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"png"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"image/png" extension:@"png" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"gif"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"image/gif" extension:@"gif" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"mov"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"video/quicktime" extension:@"mov" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"docx"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"application/msword" extension:@"docx" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"doc"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"application/msword" extension:@"doc" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"pdf"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"application/pdf" extension:@"pdf" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"txt"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"text/plain" extension:@"txt" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"rtf"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"application/rtf" extension:@"rtf" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"html"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"text/html" extension:@"html" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"xlsx"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"application/excel" extension:@"xlsx" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"xls"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"application/excel" extension:@"xls" handler:handler];
    }
    else if ([extenstion caseInsensitiveCompare:@"csv"] == NSOrderedSame)
    {
        [self upload:data mimetype:@"text/csv" extension:@"csv" handler:handler];
    }
    else
    {
        [self upload:data mimetype:@"unknown" extension:[extenstion lowercaseString] handler:handler];
        [[SKSynergy sharedInstance] errorLog:[NSString stringWithFormat:@"File %@ type is not explicitly supported.", extenstion]];
    }
}

@end
