//
//  ZHSnipButton.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
// init > set > layout

#import "ZHSnipButton.h"

@interface ZHSnipButton()


@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightVIew;

@end

@implementation ZHSnipButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *snip = [UIButton buttonWithType:UIButtonTypeCustom];
        snip.layer.borderColor = [UIColor clearColor].CGColor;
        snip.layer.borderWidth = 1;
        [snip addTarget:self action:@selector(snipImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:snip];
        self.snip = snip;
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor blackColor];
        topView.alpha = 0.3;
        [self addSubview:topView];
        self.topView = topView;
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor blackColor];
        bottomView.alpha = 0.3;
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        UIView *leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor blackColor];
        leftView.alpha = 0.3;
        [self addSubview:leftView];
        self.leftView = leftView;
        
        UIView *rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor blackColor];
        rightView.alpha = 0.3;
        [self addSubview:rightView];
        self.rightVIew = rightView;
    
    }
    
    return self;
}

- (void)setSnipButtonSize:(CGSize)snipButtonSize
{
    _snipButtonSize = snipButtonSize;
    
    self.snip.size = self.snipButtonSize;
    
    self.snip.x = (self.width - self.snip.width)/2;
    self.snip.y = (self.height - self.snip.height)/2;
    
    self.leftView.frame = CGRectMake(CGRectGetMinX(self.snip.frame) - kScreenW, self.snip.y, kScreenW, self.snip.height);
    self.rightVIew.frame = CGRectMake(CGRectGetMaxX(self.snip.frame), self.leftView.y, kScreenW, self.snip.height);
    
    self.topView.frame = CGRectMake(CGRectGetMinX(self.snip.frame) - kScreenW, CGRectGetMinY(self.snip.frame) - kScreenH, self.snip.width + 2 * kScreenW, kScreenH);
    
    self.bottomView.frame = CGRectMake(self.topView.x, CGRectGetMaxY(self.snip.frame), self.topView.width, kScreenH);
}


- (void)snipImage:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(snipButton:didClickSnip:)]) {
        
        [self.delegate snipButton:self didClickSnip:button];
    }
}


@end
