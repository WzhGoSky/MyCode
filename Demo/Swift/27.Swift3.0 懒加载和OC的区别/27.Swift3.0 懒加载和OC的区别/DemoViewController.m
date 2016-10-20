//
//  ViewController.m
//  27.Swift3.0 懒加载和OC的区别
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DemoViewController


- (UILabel *)label
{
    //如果_label = nil 就会创建
    if (!_label) {
        
        _label = [[UILabel alloc] init];
        _label.text = @"hello";
        [_label sizeToFit];
        _label.center = self.view.center;
    }
    
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //On iOS 6.0 it will no longer clear the view by default.
}
@end
