//
//  ZHHandleView.h
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHImagesView;

@protocol ZHImagesViewDelegate <NSObject>

- (void)imagesView:(ZHImagesView *)imagesView handleImagesResult:(NSArray *)resultImages;

@end

@interface ZHImagesView : UIScrollView

//需要截图的像素大小
@property (nonatomic, assign) CGSize snipSize;
//截取的比例  (高/宽) 比如0.8  就是宽:高 5:4
@property (nonatomic, assign) CGFloat snipScale;
//图片数组
@property (nonatomic, strong) NSArray *images;
//代理
@property (nonatomic, weak) id<ZHImagesViewDelegate> imagesDelegate;

+ (instancetype)imagesView;

@end
