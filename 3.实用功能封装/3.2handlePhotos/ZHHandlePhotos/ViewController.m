//
//  ViewController.m
//  ZHHandlePhotos
//
//  Created by Hayder on 16/8/8.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "ZHSnipButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZHSnipButton *button = [[ZHSnipButton alloc] initWithFrame:CGRectMake(kScreenW/2 - 50, kScreenH/2 - 50, 100, 100)];
    button.snipButtonSize = CGSizeMake(50, 50);
    
    [self.view addSubview:button];
}

@end
