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
#import "UIView+Extension.h"

@interface ZHImageVIew()<UIGestureRecognizerDelegate, UIAlertViewDelegate>

//展示的图片
@property (nonatomic, weak) UIImageView *imageView;

//裁剪按钮
//@property (nonatomic, weak) ZHSnipButton *snipButton;

@property (nonatomic, weak) UIButton *snipButton;

@end

@implementation ZHImageVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UIButton *snipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        snipButton.backgroundColor = [UIColor whiteColor];
        [snipButton addTarget:self action:@selector(snipButton:) forControlEvents:UIControlEventTouchUpInside];
        snipButton.alpha = 0.3;
        [imageView addSubview:snipButton];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        //设置需要的最少，多的手指
        pan.minimumNumberOfTouches = 1;
        pan.maximumNumberOfTouches = 3;
        pan.delegate = self;
        //将手势添加到imageView
        [snipButton addGestureRecognizer:pan];
        
        self.snipButton = snipButton;
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    //1.压缩图片
    _image = [ZHImageVIew image:image ByScale:(kScreenW * KScale) / image.size.width];
    self.imageView.image = _image;

    //2.设置裁剪的尺寸
    [self setUpSnipSizeWithImage:_image];
    
    //3.设定snipButton尺寸
    self.snipButton.size = CGSizeMake(self.snipSize.width, self.snipSize.height);
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
- (void)snipButton:(UIButton *)button
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

        self.snipButton.alpha = 1;
        self.snipButton.backgroundColor = [UIColor clearColor];
        
        if (width <= height) { //竖照片
            
            image = [ZHImageVIew imageFromView:self.imageView atFrame:CGRectMake(0, self.snipButton.y * KScale ,self.snipButton.width * KScale, self.snipButton.height *KScale)];
            
        }else
        {
            image = [ZHImageVIew imageFromView:self.imageView atFrame:CGRectMake(self.snipButton.x * KScale, 0 , self.snipButton.width * KScale, self.snipButton.height * KScale)];
  
        }
        
          if(self.snipResultBlock)
          {
              self.snipResultBlock(image);
          }
        
         [self removeFromSuperview];
    }
    
}

#pragma mark --------------------------delegate-----------------------------------------
- (void)handlePan:(UIPanGestureRecognizer *)sender
{
    if(sender.state==UIGestureRecognizerStateBegan||sender.state==UIGestureRecognizerStateChanged)
    {
        CGFloat width = self.snipSize.width;
        CGFloat height = self.snipSize.height;
        
        UIView *view = sender.view;
        CGPoint pt = [sender translationInView:sender.view];
        CGPoint c = view.center;
        
        if (width <= height) { //竖照片
            
            c.x +=0;
            c.y +=pt.y;
            
            
            CGFloat halfSnipHeight = 0.4*kScreenW;
            CGFloat y = c.y - halfSnipHeight;
            
            if (y < 0) {//靠上
                
                c.y = halfSnipHeight;
                
            }else if(c.y + halfSnipHeight > height)//靠下
            {
                c.y =  height - halfSnipHeight;
            }
        }else //横照片
        {
            c.x += pt.x;
            c.y += 0;
            
            
            CGFloat halfSnipWidth = (height * 5)/8;
            CGFloat x = c.x - halfSnipWidth;
            
            if (x < 0) {//靠左
                
                c.x = halfSnipWidth;
                
            }else if(c.x + halfSnipWidth > kScreenW)//靠右
            {
                c.x =  kScreenW - halfSnipWidth;
            }
        }
        
        view.center = c;
        
        [sender setTranslation:CGPointZero inView:sender.view];
    }
}

//手势识别器的协议方法：设置是否同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //判断两个手势是否对同一个视图的操作，如果是，可以同时识别
    if (gestureRecognizer.view==otherGestureRecognizer.view) {
        
        return YES;
    }
    return NO;
    
}

@end
