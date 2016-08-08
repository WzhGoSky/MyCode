//
//  ZHHandleView.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "ZHImagesView.h"

@interface ZHImagesView()

@property (nonatomic, strong) NSMutableArray *scaleImages;


@end

@implementation ZHImagesView

- (void)setImages:(NSArray *)images
{
    _images = images;
    
   
}

#pragma mark ------------------------lazyLoading------------------------
- (NSMutableArray *)scaleImages
{
    if (!_scaleImages) {
        
        _scaleImages = [NSMutableArray array];
        
        for(UIImage *image in self.images)
        {
            UIImage *scaleImage = [ZHImagesView image:image ByScale:(kScreenW * 2)/image.size.width];
            
            [_scaleImages addObject:scaleImage];
        }
    }
    
    return _scaleImages;
}

#pragma mark ------------------------privateFunc------------------------
+ (UIImage *)image:(UIImage *)Image ByScale:(float)scale
{
    CGSize size = Image.size;
    
    NSInteger width = size.width *scale;
    NSInteger height = size.height *scale;
    CGSize finalSize = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(finalSize);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [Image drawInRect:CGRectMake(0, 0, finalSize.width, finalSize.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
@end
