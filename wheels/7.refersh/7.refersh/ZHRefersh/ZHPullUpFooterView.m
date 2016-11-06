//
//  ZHPullUpFooterView.m
//  7.refersh
//
//  Created by Hayder on 2016/11/3.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ZHPullUpFooterView.h"

static CGFloat const footerHeight = 60;

typedef NS_ENUM(NSInteger, ZHPullUpFooterViewStatus) {
    
    ZHPullUpFooterViewStatusNormal, //正常状态
    ZHPullUpFooterViewStatusPulling, //释放刷新状态
    ZHPullUpFooterViewStatusRefreshing //正在刷新状态
};

@interface ZHPullUpFooterView()

///父控件
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *animView;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) NSArray *refershImages;

//控件状态
@property (nonatomic, assign) ZHPullUpFooterViewStatus status;

@end

@implementation ZHPullUpFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footerHeight);
        
        self.backgroundColor = [UIColor redColor];
        
        //添加子控件
        [self addSubview:self.animView];
        [self addSubview:self.title];
        
        for (UIView *view in self.subviews) {
            
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        //添加约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.animView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:-5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.animView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        //text
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        
    }
    
    return self;
}

- (void)dealloc
{
    //移除KVO的监听
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)endRefershing
{
    if (self.status == ZHPullUpFooterViewStatusRefreshing) {
        
        [self.animView stopAnimating];
        
        UIEdgeInsets contentInset = self.scrollView.contentInset;
        contentInset.bottom = contentInset.bottom - footerHeight;
        self.scrollView.contentInset = contentInset;
        
        self.status = ZHPullUpFooterViewStatusNormal;
    }
}
//监听self.tableview的contentSize的变化
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        
        self.scrollView = (UIScrollView *)newSuperview;
        
        //监听tableView的contentSize contentOffset
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
    }
}

//KVO调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGRect frame = self.frame;
        frame.origin.y = self.scrollView.contentSize.height;
        self.frame = frame;
        
    }else if ([keyPath isEqualToString:@"contentOffset"])
    {
        if (self.scrollView.isDragging) { //拖动
            
            if(self.scrollView.contentOffset.y + self.scrollView.frame.size.height < self.scrollView.contentSize.height + footerHeight)
            {
                self.status = ZHPullUpFooterViewStatusNormal;
                
            }else if((self.scrollView.contentOffset.y + self.scrollView.frame.size.height >= self.scrollView.contentSize.height + footerHeight) && self.status == ZHPullUpFooterViewStatusNormal) //当footerview完全显示并且，刷新控件的状态是normal时候才要改变状态
            {
                self.status = ZHPullUpFooterViewStatusPulling;
            }
        }else
        {
            //停止刷新，pulling -> refershing
            if(self.status == ZHPullUpFooterViewStatusPulling)
            {
                self.status = ZHPullUpFooterViewStatusRefreshing;
            }
        }
    }
}

#pragma mark ------------------------setter&&getter------------------------
- (void)setStatus:(ZHPullUpFooterViewStatus)status
{
    _status = status;
    
    switch (_status) {
            
        case ZHPullUpFooterViewStatusNormal:
            
            self.title.text = @"上拉加载数据";
            self.animView.image = [UIImage imageNamed:@"normal"];
            
            break;
        case ZHPullUpFooterViewStatusPulling:
            
            self.title.text = @"释放刷新";
            self.animView.image = [UIImage imageNamed:@"pulling"];
            
            break;
        case ZHPullUpFooterViewStatusRefreshing:
        {
            self.title.text = @"正在刷新数据...";
            
            //动画view
            self.animView.animationImages = self.refershImages;
            self.animView.animationDuration = self.refershImages.count * 0.1;
            [self.animView startAnimating];
        
            
            UIEdgeInsets contentInset = self.scrollView.contentInset;
            contentInset.bottom = contentInset.bottom + footerHeight;
            self.scrollView.contentInset = contentInset;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.scrollView.contentInset = contentInset;
                
            } completion:^(BOOL finished) {
                
                //让控制器加载数据
                if ((self.footerRefersh)) {
                    
                    self.footerRefersh();
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (UIImageView *)animView
{
    if (!_animView) {
        
        _animView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"normal"]];
    }
    
    return _animView;
}

- (UILabel *)title
{
    if (!_title) {
        
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor darkGrayColor];
        _title.font = [UIFont systemFontOfSize:16];
        _title.text = @"上拉加载更多数据";
        
        [_title sizeToFit];
    }
    
    return _title;
}


- (NSArray *)refershImages {
    
    if (!_refershImages) {
        
        NSMutableArray *refershImages = [NSMutableArray array];
        
        for (int i = 1; i < 4; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_0%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [refershImages addObject:image];
        }
    
        _refershImages = [refershImages copy];
    }
    
    return _refershImages;
}
@end
