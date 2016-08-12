//
//  ViewController.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "ZHImageVIew.h"
#import "ZHImagesView.h"

@interface ViewController ()<ZHImagesViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *images = [NSMutableArray array];
    
    UIImage *image1 = [UIImage imageNamed:@"1.jpg"];
    [images addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"2.jpeg"];
    [images addObject:image2];
    
    //1.创建对象
    ZHImagesView *imagesView = [ZHImagesView imagesView];
    //2.设置截取的比例 高/宽
    imagesView.snipScale = 1;
    //3.设置要处理的图片数组
    imagesView.images = images;
    //4.设置代理
    imagesView.imagesDelegate = self;
    //5.添加到视图上
    [self.view addSubview:imagesView];
    
}

- (void)imagesView:(ZHImagesView *)imagesView handleImagesResult:(NSArray *)resultImages
{
    NSLog(@"%@",resultImages);
}

@end
