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

#ifndef SynergyKit_SCacheType_h
#define SynergyKit_SCacheType_h

/**
 *  This enum is set of available cache types.
 */
typedef NS_ENUM(NSInteger, SCacheType) {
    /**
     *  Synergykit Cache Type prefers fresh data over cached one. Works with expiration interval.
     */
    SCacheTypeLoadElseCache = -1,
    /**
     *  Synergykit Cache Type prefers cached data over downloading fresh one. Works with expiration interval.
     */
    SCacheTypeCacheElseLoad = -2,

    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemUseProtocolCachePolicy = 0,
    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemReloadIgnoringLocalCacheData = 1,
    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemReloadIgnoringLocalAndRemoteCacheData = 4,
    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemReloadIgnoringCacheData = SCacheTypeSystemReloadIgnoringLocalCacheData,
    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemReturnCacheDataElseLoad = 2,
    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemReturnCacheDataDontLoad = 3,
    /**
     *  System cache type (NSURLRequestCachePolicy).
     */
    SCacheTypeSystemReloadRevalidatingCacheData = 5
};

#endif