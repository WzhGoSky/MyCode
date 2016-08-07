//
//  UIControl+Delay.h
//  DelayButton
//
//  Created by Hayder on 16/8/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (clickDelay)

/**
 *  延时时间
 */
@property (nonatomic, assign) NSTimeInterval delayTime;

/**
 *  是否延时
 */
@property (nonatomic, assign) BOOL isDelay;


@end
