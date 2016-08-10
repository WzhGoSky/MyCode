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
@property (nonatomic, weak) UIButton *snipButton;

@property (nonatomic, weak) UIView *topOrLeftView;

@property (nonatomic, weak) UIView *bottomOrRightView;

@end

@implementation ZHImageVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UIButton *snipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        snipButton.backgroundColor = [UIColor clearColor];
        [snipButton addTarget:self action:@selector(snipButton:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:snipButton];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        
        //设置需要的最少，多的手指
        pan.minimumNumberOfTouches = 1;
        pan.maximumNumberOfTouches = 3;
        pan.delegate = self;
        //将手势添加到imageView
        [snipButton addGestureRecognizer:pan];
        self.snipButton = snipButton;
        
        //上侧阴影
        UIView *topOrLeftView = [[UIView alloc] init];
        topOrLeftView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
        [self.imageView addSubview:topOrLeftView];
        self.topOrLeftView = topOrLeftView;
        
        //下侧阴影
        UIView *bottomOrRightView = [[UIView alloc] init];
        bottomOrRightView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
        [self.imageView addSubview:bottomOrRightView];
        self.bottomOrRightView = bottomOrRightView;
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
    
    if (width < height) { //竖
        
        self.topOrLeftView.frame = CGRectMake(0, CGRectGetMinY(self.snipButton.frame) - self.topOrLeftView.height,self.topOrLeftView.width, self.topOrLeftView.height);
        self.bottomOrRightView.frame = CGRectMake(0, CGRectGetMaxY(self.snipButton.frame), self.bottomOrRightView.width,self.bottomOrRightView.height);
    }else //横
    {
        self.topOrLeftView.frame = CGRectMake(CGRectGetMinX(self.snipButton.frame) - self.topOrLeftView.width, 0,self.topOrLeftView.width, self.topOrLeftView.height);
        self.bottomOrRightView.frame = CGRectMake(CGRectGetMaxX(self.snipButton.frame), 0, self.bottomOrRightView.width,self.bottomOrRightView.height);
    }
    
    NSLog(@"----");
}

- (void)setUpSnipSizeWithImage:(UIImage *)image
{
    CGFloat height = image.size.height/KScale;
    
    if (self.snipSize.width == 0 || self.snipSize.height == 0) { //没有设置裁剪的尺寸
        
        if (image.size.width >= image.size.height) { //横照片
            
            self.snipSize = CGSizeMake(1/self.snipScale * height, height);
            
            self.topOrLeftView.width = kScreenW;
            self.topOrLeftView.height = self.snipSize.height;
            
            self.bottomOrRightView.width = kScreenW;
            self.bottomOrRightView.height = self.snipSize.height;
            
        }else //竖照片
        {
            self.snipSize = CGSizeMake(kScreenW, self.snipScale * kScreenW);
            
            self.topOrLeftView.width = self.snipSize.width;
            self.topOrLeftView.height = kScreenH;
            
            self.bottomOrRightView.width = self.snipSize.width;
            self.bottomOrRightView.height = kScreenH;
        }
    }
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
        
        if (width <= height) { //竖照片
            
            image = [ZHImageVIew imageFromView:self.imageView atFrame:CGRectMake(0, self.snipButton.y * KScale ,self.snipButton.width * KScale, self.snipButton.height *KScale)];
            
        }else
        {
            image = [ZHImageVIew imageFromView:self.imageView atFrame:CGRectMake(self.snipButton.x * KScale, 0 , self.snipButton.width * KScale, self.snipButton.height * KScale)];
  
        }
        
          if(self.snipResultBlock)
          {
              self.snipResultBlock(image,self.tag);
          }
        
         [self removeFromSuperview];
    }
    
}

#pragma mark --------------------------delegate-----------------------------------------
- (void)handlePan:(UIPanGestureRecognizer *)sender
{
    if(sender.state==UIGestureRecognizerStateBegan||sender.state==UIGestureRecognizerStateChanged)
    {
        CGFloat width = self.image.size.width / KScale;
        CGFloat height = self.image.size.height / KScale;
        
        UIView *view = sender.view;
        CGPoint pt = [sender translationInView:sender.view];
        CGPoint c = view.center;
        
        
        CGPoint topOrLeftViewC = self.topOrLeftView.center;
        CGPoint bottomOrRightViewC = self.bottomOrRightView.center;
        
        if (width <= height) { //竖照片
            
            c.x +=0;
            c.y +=pt.y;
            
            topOrLeftViewC.x +=0;
            topOrLeftViewC.y +=pt.y;
            
            bottomOrRightViewC.x +=0;
            bottomOrRightViewC.y +=pt.y;
            
            CGFloat halfSnipHeight = 0.5 * self.snipButton.height;
            CGFloat y = c.y - halfSnipHeight;
            
            if (y < 0) {//靠上
                
                c.y = halfSnipHeight;
                
                topOrLeftViewC.y = - self.topOrLeftView.height * 0.5;
                bottomOrRightViewC.y = 2 * halfSnipHeight + 0.5 * self.bottomOrRightView.height;
                
            }else if(c.y + halfSnipHeight > height)//靠下
            {
                c.y =  height - halfSnipHeight;
                
                topOrLeftViewC.y = c.y - halfSnipHeight - 0.5 * self.topOrLeftView.height;
                bottomOrRightViewC.y = c.y + halfSnipHeight + 0.5 * self.bottomOrRightView.height;
            }
        }else //横照片
        {
            c.x += pt.x;
            c.y += 0;
            
            topOrLeftViewC.x += pt.x;
            topOrLeftViewC.y +=0;
            
            bottomOrRightViewC.x +=pt.x;
            bottomOrRightViewC.y +=0;
            
            CGFloat halfSnipWidth = 0.5 * self.snipButton.width;
            CGFloat x = c.x - halfSnipWidth;
            
            if (x < 0) {//靠左
                
                c.x = halfSnipWidth;
                
                topOrLeftViewC.x = - self.topOrLeftView.width * 0.5;
                bottomOrRightViewC.x = 2 * halfSnipWidth + 0.5 * self.bottomOrRightView.width;
                
            }else if(c.x + halfSnipWidth > kScreenW)//靠右
            {
                c.x =  kScreenW - halfSnipWidth;
                
                topOrLeftViewC.x = kScreenW - 2 * halfSnipWidth - 0.5 * self.topOrLeftView.width;
                bottomOrRightViewC.x = kScreenW + 0.5 * self.bottomOrRightView.width;

            }
        }
        
        view.center = c;
        
        self.topOrLeftView.center = topOrLeftViewC;
        self.bottomOrRightView.center = bottomOrRightViewC;
        
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

@end
