//
//  ZHHandleView.h
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHImagesView : UIScrollView

//需要截图的像素大小
@property (nonatomic, assign) CGSize snipSize;
//图片数组
@property (nonatomic, strong) NSArray *images;

@end
