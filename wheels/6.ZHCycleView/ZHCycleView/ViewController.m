//
//  ViewController.m
//  ZHCycleView
//
//  Created by WZH on 16/8/16.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ViewController.h"
#import "ZHCycleView.h"

@interface ViewController ()<ZHCycleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZHCycleView *cycleView = [[ZHCycleView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 0.4 * [UIScreen mainScreen].bounds.size.width)];
    cycleView.imageArr = @[@"slider_pic_01.jpg",@"slider_pic_02.jpg",@"slider_pic_03.jpg",@"slider_pic_04.jpg",@"slider_pic_05.jpg",@"slider_pic_06.jpg"];
//    cycleView.urlArr = @[@"http://192.168.10.100:81/uploadimg/goods/mid/2aa720f8-9b82-9a12-7607-9fcd20c4b071.png",@"http://192.168.0.179:81/uploadimg/goods/mid/b1c6da6b-e241-97db-5bd1-53f4d1405d5a.jpg"];
    cycleView.delegate = self;
    [self.view addSubview:cycleView];
}

#pragma mark --------------------------delegate-----------------------------------------
- (void)cycleView:(ZHCycleView *)cycleView didSelectedViewAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
