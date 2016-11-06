//
//  UIScrollView+Refersh.h
//  7.refersh
//
//  Created by Hayder on 2016/11/6.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPullUpFooterView.h"
#import "ZHPullDownHeaderView.h"

@interface UIScrollView (Refersh)

@property (nonatomic, strong) ZHPullDownHeaderView *headerView;

@property (nonatomic, strong) ZHPullUpFooterView *footerView;

@end
