//
//  NSTimer+WeakTimer.h
//  Football_talk_iphone
//
//  Created by pzk on 17/4/7.
//  Copyright © 2017年 Aone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WeakTimer)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                    repeats:(BOOL)repeats
                               handlerBlock:(void(^)())handler;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                           repeats:(BOOL)repeats
                      handlerBlock:(void (^)(NSTimer *timer))handler;

@end
