//
//  ViewController.m
//  objectKeyValues
//
//  Created by WZH on 16/8/12.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+keyValues.h"
#import "student.h"
#import "School.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *sts = [NSMutableArray array];
//    student *st = [[student alloc] init];
//    st.name = @"wzh";
//    [sts addObject:st];
//    student *st2 = [[student alloc] init];
//    st2.name = @"wss";
//    [sts addObject:st2];
    
    School *school = [[School alloc] init];
//    school.age = @(100);
//    school.name = @"要塞";
//    school.st = sts;
    school.bo = YES;
    school.doub = 80.1000;
    school.inter = 10;
    school.Uinter = 20;
    school.cgfloat = 1000;
    school.f  = 2000.00;
    
    NSLog(@"%@",school.keyValues);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
