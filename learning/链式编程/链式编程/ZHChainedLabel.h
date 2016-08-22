//
//  ZHChainedLabel.h
//  链式编程
//
//  Created by WZH on 16/8/19.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHChainedLabel;

typedef ZHChainedLabel *(^frameBlock)(CGRect frame);
typedef ZHChainedLabel *(^FontBlock)(NSInteger size);
typedef ZHChainedLabel *(^TextBlock)(NSString *text);
typedef ZHChainedLabel *(^addSubviewsBlock)(UIView *view);
typedef ZHChainedLabel *(^textColorBlock)(UIColor *color);
typedef ZHChainedLabel *(^addToSuperView)(UIView *superview);

@interface ZHChainedLabel : UILabel

@property (nonatomic, copy) FontBlock ZHFont;
@property (nonatomic, copy) TextBlock ZHText;
@property (nonatomic, copy) textColorBlock ZHColor;
@property (nonatomic, copy) addSubviewsBlock addSubviews;
@property (nonatomic, copy) addToSuperView addToSuperview;
@property (nonatomic, copy) frameBlock ZHFrame;

@end
