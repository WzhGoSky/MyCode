//
//  ZHSnipButton.h
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

typedef NS_ENUM(NSInteger, imageType)
{
    imageTypePortrait = 1, //竖
    imageTypeLandscape //横
};


@class ZHSnipButton;

@protocol ZHSnipButtonDelegate <NSObject>

@required
- (void)snipButton:(ZHSnipButton *)SnipButton didClickSnip:(UIButton *)button;

@end

@interface ZHSnipButton : UIView

//照片类型
@property (nonatomic, assign) imageType type;

@property (nonatomic, assign) CGSize snipButtonSize;

@property (nonatomic, weak) id<ZHSnipButtonDelegate> delegate;

//裁剪按钮
@property (nonatomic, weak) UIButton *snip;

@end
