//
//  ZHSnipButton.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
// init > set > layout

#import "ZHSnipButton.h"

@interface ZHSnipButton()

@property (nonatomic, weak) UIButton *snip;
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightVIew;

@end

@implementation ZHSnipButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.clipsToBounds = YES;
        UIButton *snip = [UIButton buttonWithType:UIButtonTypeCustom];
        snip.layer.borderColor = [UIColor whiteColor].CGColor;
        snip.layer.borderWidth = 1;
        [self addSubview:snip];
        self.snip = snip;
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:topView];
        self.topView = topView;
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        UIView *leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:leftView];
        self.leftView = leftView;
        
        UIView *rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:rightView];
        self.rightVIew = rightView;
    
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.snip.size = self.snipButtonSize;
    self.snip.x = (self.width - self.snip.width)/2;
    self.snip.y = (self.height - self.snip.height)/2;
    
    self.leftView.frame = CGRectMake(CGRectGetMinX(self.snip.frame) - kScreenW, self.centerY - 0.5*kScreenH, kScreenW, kScreenH);
    self.rightVIew.frame = CGRectMake(CGRectGetMaxX(self.snip.frame), self.leftView.y, kScreenW, kScreenH);
    
    self.topView.frame = CGRectMake(CGRectGetMinX(self.snip.frame), CGRectGetMinY(self.snip.frame) - kScreenH, self.snip.width, kScreenH);
    self.bottomView.frame = CGRectMake(CGRectGetMinY(self.snip.frame), CGRectGetMaxY(self.snip.frame), self.snip.width, kScreenH);
    
    NSLog(@"---");
}
@end
