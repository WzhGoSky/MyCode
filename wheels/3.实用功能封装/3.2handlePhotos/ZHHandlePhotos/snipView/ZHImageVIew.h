//
//  ZHImageVIew.h
//  ZHHandlePhotos
//
//  Created by Hayder on 15/8/8.
//  Copyright © 2015年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^snipResult)(UIImage *image, NSInteger tag);

@interface ZHImageVIew : UIView

//裁剪的比例
@property (nonatomic, assign) CGFloat snipScale;
//裁剪尺寸
@property (nonatomic, assign) CGSize snipSize;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) snipResult snipResultBlock;

@end
