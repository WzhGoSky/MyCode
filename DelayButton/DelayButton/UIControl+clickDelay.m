//
//  UIControl+Delay.m
//  DelayButton
//
//  Created by Hayder on 16/8/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "UIControl+clickDelay.h"
#import <objc/runtime.h>

@implementation UIControl (clickDelay)

+ (void)load
{
    Method original_Method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    Method add_Method = class_getInstanceMethod(self, @selector(delay_sendAction:to:forEvent:));
    
    //把系统的方法替换成自己的方法
    method_exchangeImplementations(original_Method, add_Method);
}
#pragma mark ------------------------setter&getter------------------------
- (void)setIsDelay:(BOOL)isDelay
{
    objc_setAssociatedObject(self, @"isDelay", @(isDelay), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isDelay
{
    return [objc_getAssociatedObject(self, @"isDelay") boolValue];
}

- (void)setDelayTime:(NSTimeInterval)delayTime
{
    objc_setAssociatedObject(self, @"delayTime", @(delayTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)delayTime
{
   return [objc_getAssociatedObject(self, @"delayTime") doubleValue];
}

/**
 *  延时方法
 */
- (void)delay_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if(self.isDelay) return;
    
    if (self.delayTime > 0) {
        
        self.isDelay = YES;
        
        [self performSelector:@selector(setIsDelay:) withObject:@(NO) afterDelay:self.delayTime];
    }
    
    [self delay_sendAction:action to:target forEvent:event];
}

@end
