//
//  UIImageView+Download.h
//  ZHCycleView
//
//  Created by WZH on 16/8/16.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHImageDownloadManager.h"

@interface UIImageView (Download)

//下载网络图片
- (UIImageView *)setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

@end
