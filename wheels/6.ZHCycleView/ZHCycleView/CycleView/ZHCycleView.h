//
//  EPCycleView.h
//  FisheryMarket
//
//  Created by WZH on 16/5/18.
//  Copyright © 2016年 王振海. All rights reserved.
// cunhuan

#import <UIKit/UIKit.h>

@class ZHCycleView;

@protocol  ZHCycleViewDelegate <NSObject>

- (void)cycleView:(ZHCycleView *)cycleView didSelectedViewAtIndex:(NSInteger)index;

@end

@interface ZHCycleView : UIView

/**
 *  images
 */
/**
 *  网络图片 (数组中元素类型 ： NSString)
 */
@property (nonatomic, strong) NSArray *urlArr;

/**
 *  本地图片 (数组中元素类型 ： NSString)
 */
@property (nonatomic, strong) NSArray *imageArr;


@property (nonatomic, weak) id<ZHCycleViewDelegate> delegate;


/**
 *  pageController
 */
//未选中的颜色
@property (nonatomic, strong) UIColor *indicatorTintColor;

//当前页的颜色
@property (nonatomic, strong) UIColor *currentTintColor;

@end
