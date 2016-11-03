//
//  ZHPullUpFooterView.m
//  7.refersh
//
//  Created by Hayder on 2016/11/3.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ZHPullUpFooterView.h"

static CGFloat const footerHeight = 60;

@interface ZHPullUpFooterView()

///父控件
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *animView;

@property (nonatomic, strong) UILabel *text;

@property (nonatomic, strong) NSArray *refershImages;
@end

@implementation ZHPullUpFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footerHeight);
        
        self.backgroundColor = [UIColor redColor];
        
        //添加子控件
        [self addSubview:self.animView];
        [self addSubview:self.text];
        
        for (UIView *view in self.subviews) {
            
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        //添加约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.animView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:-5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.animView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        //text
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.text attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.text attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        
    }
    
    return self;
}

- (void)dealloc
{
    //移除KVO的监听
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

//监听self.tableview的contentSize的变化
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        
        self.scrollView = (UIScrollView *)newSuperview;
        
        //监听tableView的contentSize
        
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        
    }
}

//KVO调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        //设置刷新控件的frame
        CGRect frame = self.frame;
        frame.origin.y = self.scrollView.contentSize.height;
        self.frame = frame;
        
    }
}

- (UIImageView *)animView
{
    if (!_animView) {
        
        _animView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"normal"]];
    }
    
    return _animView;
}

- (UILabel *)text
{
    if (!_text) {
        
        _text = [[UILabel alloc] init];
        _text.textColor = [UIColor darkGrayColor];
        _text.font = [UIFont systemFontOfSize:16];
        _text.text = @"上拉加载更多数据";
        
        [_text sizeToFit];
    }
    
    return _text;
}


- (NSArray *)refershImages {
    
    if (!_refershImages) {
        
        NSMutableArray *refershImages = [NSMutableArray array];
        
        for (int i = 1; i < 4; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"refersh_%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [refershImages addObject:image];
        }
    
        _refershImages = [refershImages copy];
    }
    
    return _refershImages;
}
@end
