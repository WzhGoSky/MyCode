//
//  ZHHandleView.m
//  ZHHandlePhotos
//
//  Created by Hayder on 15/8/8.
//  Copyright © 2015年 wangzhenhai. All rights reserved.
//

#import "ZHImagesView.h"
#import "ZHImageVIew.h"

@interface ZHImagesView()

/**
 *  处理好的图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArr;

/**
 *  页码
 */
@property (nonatomic, strong) UILabel *pageNum;

@end

@implementation ZHImagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor blackColor];
        self.scrollEnabled = NO;
    }
    
    return self;
}

+ (instancetype)imagesView
{
    ZHImagesView *imagesView = [[ZHImagesView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    return imagesView;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    for (int i = 0; i < images.count; i++) {
        
        UIImage *image = self.images[i];
        
        ZHImageVIew *imageView = [[ZHImageVIew alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width *i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imageView.snipScale = self.snipScale;
        imageView.image = image;
        imageView.tag = i;
        [self addSubview:imageView];
        
        __weak typeof(self) weakSelf = self;
        imageView.snipResultBlock = ^(UIImage *image,NSInteger tag){
        
            [weakSelf.imageArr addObject:image];
            
            if (tag == weakSelf.images.count - 1) { //最后一张
                
                if ([weakSelf.imagesDelegate respondsToSelector:@selector(imagesView:handleImagesResult:)]) {
                    
                    [weakSelf.imagesDelegate imagesView:weakSelf handleImagesResult:weakSelf.imageArr];
                }
                
                [weakSelf removeFromSuperview];
            }else
            {
                 weakSelf.contentOffset = CGPointMake((tag+1) * [UIScreen mainScreen].bounds.size.width, 0);
            }
        };
       
    }

    self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.images.count, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark ------------------------lazyLoading------------------------
- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        
        _imageArr = [NSMutableArray array];
    }
    
    return _imageArr;
}

@end
