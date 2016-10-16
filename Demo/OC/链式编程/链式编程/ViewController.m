//
//  ViewController.m
//  链式编程
//
//  Created by WZH on 16/8/19.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ViewController.h"
#import "ZHChainedLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ZHChainedLabel *label = [[ZHChainedLabel alloc] init];
    label.ZHFrame(CGRectMake(100, 100, 100, 100)).ZHFont(15).ZHText(@"haha").ZHColor([UIColor redColor]).addToSuperview(self.view);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
