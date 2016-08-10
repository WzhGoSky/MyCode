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
    
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        
        UIImage *image = [UIImage imageNamed:@"1.jpg"];
        [images addObject:image];
    }
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)imagesView:(ZHImagesView *)imagesView handleImagesResult:(NSArray *)resultImages
{
    NSLog(@"%@",resultImages);
}

@end
