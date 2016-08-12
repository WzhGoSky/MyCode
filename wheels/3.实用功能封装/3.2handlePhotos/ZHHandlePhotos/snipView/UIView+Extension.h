//
//  UIView+Extension.h
//  FisheryMarket
//
//  Created by WZH on 15/5/1.
//  Copyright © 2016年 王振海. All rights reserved.
// 直接访问视图的x，y，w,h centerX centerY方法

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end
