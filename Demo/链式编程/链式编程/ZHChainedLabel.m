//
//  ZHChainedLabel.m
//  链式编程
//
//  Created by WZH on 16/8/19.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ZHChainedLabel.h"

@implementation ZHChainedLabel

- (TextBlock)ZHText
{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}


- (FontBlock)ZHFont
{
    return ^(NSInteger size){
        
        self.font = [UIFont systemFontOfSize:size];
        
        return self;
    };
}

- (addSubviewsBlock)addSubviews
{
    return ^(UIView *view){
    
        [self addSubview:view];
        return self;
    };
}


- (addToSuperView)addToSuperview
{
    return ^(UIView *view)
    {
        [view addSubview:self];
        
        return self;
    };
}

- (frameBlock)ZHFrame
{
    return ^(CGRect frame){
        
        self.frame = frame;
        return self;
    };
}

- (textColorBlock)ZHColor
{
    return ^(UIColor *color)
    {
        self.textColor = color;
        return self;
    };
}
@end
