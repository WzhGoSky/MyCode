//
//  ViewController.m
//  DelayButton
//
//  Created by Hayder on 16/8/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+clickDelay.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *delayButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.delayButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.delayButton.delayTime = 1;
}

- (void)clickButton:(UIButton *)button
{
    NSLog(@"----");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
