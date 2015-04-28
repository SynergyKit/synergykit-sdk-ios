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

#ifndef Pods_SObserverConnectionState_h
#define Pods_SObserverConnectionState_h

/**
 *  This enum is set of connection state of observers.
 */
typedef NS_ENUM(NSInteger, SObserverConnectionState) {
    /**
     *  Connection was connected
     */
    SObserverConnectionStateConnected,
    /**
     *  Connection was disconnected
     */
    SObserverConnectionStateDisconnected,
    /**
     *  Connection was reconnected
     */
    SObserverConnectionStateReconnected
};

#endif
