//
//  ZHPullDownHeaderView.h
//  7.refersh
//
//  Created by Hayder on 2016/11/6.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPullDownHeaderView : UIView

@property (nonatomic, copy) void(^headerRefersh)();

- (void)endRefershing;

@end
