//
//  UIScrollView+Refersh.m
//  7.refersh
//
//  Created by Hayder on 2016/11/6.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "UIScrollView+Refersh.h"
#import <objc/runtime.h>

static const char *headerViewKey = "headerViewKey";

static const char *footerViewKey = "footerView";

@implementation UIScrollView (Refersh)

- (void)setHeaderView:(ZHPullDownHeaderView *)headerView
{
    objc_setAssociatedObject(self, headerViewKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZHPullDownHeaderView *)headerView
{
    ZHPullDownHeaderView *headerView = objc_getAssociatedObject(self, headerViewKey);
    
    if (!headerView) {
        
        headerView = [[ZHPullDownHeaderView alloc] init];
        
        [self addSubview:headerView];
        
        self.headerView = headerView;
    }
    
    return headerView;
}

- (void)setFooterView:(ZHPullUpFooterView *)footerView
{
    objc_setAssociatedObject(self,footerViewKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZHPullUpFooterView *)footerView
{
    ZHPullUpFooterView *footerView = objc_getAssociatedObject(self, footerViewKey);
    
    if (!footerView) {
        
        footerView = [[ZHPullUpFooterView alloc] init];
        
        [self addSubview:footerView];
        
        //保存对象
        self.footerView = footerView;
    }
    
    return footerView;
}



@end
