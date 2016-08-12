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
    
    School *school = [[School alloc] init];
    school.age = 100;
    school.name = @"要塞";
    student *st = [[student alloc] init];
//    st.age = 10;
    st.name = @"wzh";
    school.st = st;
    
    NSLog(@"%@",[school modelToKeyValues]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
