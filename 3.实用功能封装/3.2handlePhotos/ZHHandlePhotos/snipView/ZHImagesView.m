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
        
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor blackColor];
        self.scrollEnabled = NO;
        
        //页码显示
        UILabel *pageNum = [[UILabel alloc] init];
        pageNum.textColor = [UIColor whiteColor];
        pageNum.backgroundColor = [UIColor blackColor];
        pageNum.textAlignment = NSTextAlignmentCenter;
        pageNum.frame = CGRectMake(0, kScreenH - 20, kScreenW, 20);
        self.pageNum = pageNum;
    }
    
    return self;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    
    for (int i = 0; i < images.count; i++) {
        
        CGFloat width = image.size.width/2;
        CGFloat height = image.size.height/2;
        
        
        if (i == 0) {
            
            self.pageNum.text = [NSString stringWithFormat:@"%d/%ld",i+1,(unsigned long)self.photos.count];
        }
       
    }
    
    [self addSubview:self.pageNum];
    self.contentSize = CGSizeMake(kScreenW * self.images.count, kScreenH);
}

#pragma mark ------------------------lazyLoading------------------------
- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        
        _imageArr = [NSMutableArray array];
    }
    
    return _imageArr;
}

#pragma mark ------------------------privateFunc------------------------

@end
