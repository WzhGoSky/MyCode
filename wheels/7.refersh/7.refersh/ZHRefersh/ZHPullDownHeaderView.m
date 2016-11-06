//
//  ZHPullDownHeaderView.m
//  7.refersh
//
//  Created by Hayder on 2016/11/6.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ZHPullDownHeaderView.h"

static CGFloat const headerHeight = 60;

typedef NS_ENUM(NSInteger, ZHPullDownHeaderViewStatus) {
    
    ZHPullDownHeaderViewStatusNormal, //正常状态
    ZHPullDownHeaderViewStatusPulling, //释放刷新状态
    ZHPullDownHeaderViewStatusRefreshing //正在刷新状态
};

@interface ZHPullDownHeaderView()

///父控件
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *animView;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) NSArray *refershImages;

@property (nonatomic, assign) ZHPullDownHeaderViewStatus status;

@end

@implementation ZHPullDownHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerHeight);
        
        self.backgroundColor = [UIColor whiteColor];
        
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
    if (self.status == ZHPullDownHeaderViewStatusRefreshing) {
        
        [self.animView stopAnimating];
        
        UIEdgeInsets contentInset = self.scrollView.contentInset;
        contentInset.top = contentInset.top - headerHeight;
        self.scrollView.contentInset = contentInset;
        
        self.status = ZHPullDownHeaderViewStatusNormal;
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
        frame.origin.y = - headerHeight;
        self.frame = frame;
        
    }else if ([keyPath isEqualToString:@"contentOffset"])
    {
        
        if (self.scrollView.isDragging) { //拖动
            
            if(self.scrollView.contentOffset.y > -headerHeight - 64)
            {
                self.status = ZHPullDownHeaderViewStatusNormal;
                
            }else if((self.scrollView.contentOffset.y <= -headerHeight - 64) && self.status == ZHPullDownHeaderViewStatusNormal) //当footerview完全显示并且，刷新控件的状态是normal时候才要改变状态
            {
                self.status = ZHPullDownHeaderViewStatusPulling;
            }
        }else
        {
            //停止刷新，pulling -> refershing
            if(self.status == ZHPullDownHeaderViewStatusPulling)
            {
                self.status = ZHPullDownHeaderViewStatusRefreshing;
            }
        }
    }
}

#pragma mark ------------------------setter & getter------------------------
- (void)setStatus:(ZHPullDownHeaderViewStatus)status
{
    _status = status;
    
    switch (_status) {
            
        case ZHPullDownHeaderViewStatusNormal:
            
            self.title.text = @"下拉刷新数据";
            self.animView.image = [UIImage imageNamed:@"normal"];
            
            break;
        case ZHPullDownHeaderViewStatusPulling:
            
            self.title.text = @"释放刷新";
            self.animView.image = [UIImage imageNamed:@"pulling"];
            
            break;
        case ZHPullDownHeaderViewStatusRefreshing:
        {
            self.title.text = @"正在刷新数据...";
            
            //动画view
            self.animView.animationImages = self.refershImages;
            self.animView.animationDuration = self.refershImages.count * 0.1;
            [self.animView startAnimating];
            
            
            UIEdgeInsets contentInset = self.scrollView.contentInset;
            contentInset.top = contentInset.top + headerHeight;
            self.scrollView.contentInset = contentInset;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.scrollView.contentInset = contentInset;
                
            } completion:^(BOOL finished) {
                
                //让控制器加载数据
                if ((self.headerRefersh)) {
                    
                    self.headerRefersh();
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
