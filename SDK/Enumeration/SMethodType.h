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

#ifndef SynergyKit_SMethodType_h
#define SynergyKit_SMethodType_h

/**
 *  This enum is set of available REST API methods.
 */
typedef NS_ENUM(NSInteger, SMethodType) {
    /**
     *  POST request or created event
     */
    SMethodTypePOST,
    /**
     *  PUT request or updated event
     */
    SMethodTypePUT,
    /**
     *  PATCH request or patched event
     */
    SMethodTypePATCH,
    /**
     *  DELETE request or deleted event
     */
    SMethodTypeDELETE,
    /**
     *  GET request
     */
    SMethodTypeGET
};

#endif