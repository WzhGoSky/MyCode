//
//  ViewController.m
//  codeScanner
//
//  Created by WZH on 16/3/9.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ViewController.h"
#import "ZHScanView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZHScanView *scanf = [ZHScanView scanView];
//    ZHScanView *scanf = [ZHScanView scanViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    scanf.promptMessage = @"您可以直接输入或者选择扫描二维码";
    [self.view addSubview:scanf];
    
    [scanf startScaning];
    
    [scanf outPutResult:^(NSString *result) {
        
        NSLog(@"%@",result);
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
