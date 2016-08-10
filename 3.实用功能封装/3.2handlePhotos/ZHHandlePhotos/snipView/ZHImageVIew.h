//
//  ZHImageVIew.h
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHImageVIew : UIView

//裁剪的比例
@property (nonatomic, assign) CGFloat snipScale;
//裁剪尺寸
@property (nonatomic, assign) CGSize snipSize;

@property (nonatomic, strong) UIImage *image;

@end
