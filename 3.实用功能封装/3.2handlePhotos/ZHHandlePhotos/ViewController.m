//
//  ViewController.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "ZHImageVIew.h"
#import "ZHSnipButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    ZHSnipButton *button = [[ZHSnipButton alloc] initWithFrame:CGRectMake(kScreenW/2 - 50, kScreenH/2 - 50, 100, 100)];
//    button.snipButtonSize = CGSizeMake(50, 50);
//    
//    [self.view addSubview:button];
    
    ZHImageVIew *imageview = [[ZHImageVIew alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height - 20)];
    imageview.image  = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageview];
}

@end
