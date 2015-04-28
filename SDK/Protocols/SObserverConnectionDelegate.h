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

#ifndef Pods_SObserverConnectionDelegate_h
#define Pods_SObserverConnectionDelegate_h

@protocol SObserverConnectionDelegate

/**
 *  Observers connection changed state. This callback handles connection events, not event of observers!
 *
 *  @param state New connection state
 */
-(void) observingConnectionDidChangeState:(SObserverConnectionState)state;

@end

#endif
