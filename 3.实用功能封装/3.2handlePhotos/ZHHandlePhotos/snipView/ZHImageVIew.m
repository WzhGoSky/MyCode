//
//  ZHImageVIew.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define KScale [UIScreen mainScreen].scale
#import "ZHImageVIew.h"
#import "ZHSnipButton.h"

@interface ZHImageVIew()<ZHSnipButtonDelegate>

//展示的图片
@property (nonatomic, weak) UIImageView *imageView;

//裁剪按钮
@property (nonatomic, weak) ZHSnipButton *snipButton;


@end

@implementation ZHImageVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        ZHSnipButton *button = [[ZHSnipButton alloc] init];
        button.delegate = self;
        button.backgroundColor = [UIColor clearColor];
        [imageView addSubview:button];
        self.snipButton = button;
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    //1.压缩图片
    _image = [ZHImageVIew image:image ByScale:(kScreenW * KScale) / image.size.width];
    self.imageView.image = _image;

    //2.判断一下是否设置裁剪的尺寸
    [self setUpSnipSizeWithImage:_image];
    
    //3.设定snipButton尺寸
    self.snipButton.size = CGSizeMake(2 * kScreenW + self.snipSize.width, 2 * kScreenH + self.snipSize.height);
    
    //4.将图片裁剪尺寸赋值
    self.snipButton.snipButtonSize = self.snipSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = _image.size.width/KScale;
    CGFloat height = _image.size.height/KScale;
    
    self.imageView.frame = CGRectMake((kScreenW - width)/2, (self.height - height)/2, width, height);
    
    self.snipButton.center = CGPointMake(self.imageView.width/2, self.imageView.height/2);
}

- (void)setUpSnipSizeWithImage:(UIImage *)image
{
    CGFloat height = image.size.height/KScale;
    
    if (self.snipSize.width == 0 || self.snipSize.height == 0) { //没有设置裁剪的尺寸
        
        if (image.size.width >= image.size.height) { //横照片
            
            self.snipSize = CGSizeMake(1.25 * height, height);
            
        }else //竖照片
        {
            self.snipSize = CGSizeMake(kScreenW, 0.8 * kScreenW);
        }
    }
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

+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r
{
    // 1.开启图形上下文
    CGSize imageSize = theView.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 2.将某个view的所有内容渲染到图形上下文中
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    
    // 3.取得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef subimageRef = CGImageCreateWithImageInRect(image.CGImage, r);
    
    UIImage *subImage = [UIImage imageWithCGImage:subimageRef];
    
    //释放subImageRef 防止内存泄露
    CGImageRelease(subimageRef);
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return subImage;
    
}

#pragma mark --------------------------ZHSnipButtonDelegate-----------------------------------------
- (void)snipButton:(ZHSnipButton *)SnipButton didClickSnip:(UIButton *)button
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否确定截图" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark --------------------------alertViewDelegate-----------------------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) { //确认截图
        
        UIImage *image = nil;
        
        CGFloat width = _imageView.width;
        CGFloat height = _imageView.height;
        
        UIButton *button = self.snipButton.snip;
        
        //坐标系转换 A 有一个控件B 想知道 转换到C上的坐标  [A convertRect:B.frame toView:C]
        CGRect snipRect = [self.snipButton convertRect:self.snipButton.snip.frame toView:self.imageView];
        
        if (width <= height) { //竖照片
            
            image = [ZHImageVIew imageFromView:self.imageView atFrame:CGRectMake(0, snipRect.origin.y * KScale ,button.width * KScale, button.height *KScale)];
            
        }else
        {
            image = [ZHImageVIew imageFromView:self.imageView atFrame:CGRectMake(snipRect.origin.x * KScale, 0 , button.width * KScale, button.height * KScale)];
  
        }
        
//        self.imageView.size = CGSizeMake(image.size.width / KScale, image.size.height/KScale);
//        self.imageView.image = image;
        
        [self.snipButton.snip setBackgroundImage:image forState:UIControlStateNormal];
//        [self.snipButton removeFromSuperview];
    }
    
}


@end
