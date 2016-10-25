//
//  ViewController.m
//  16.Swift3.0 - 循环引用
//
//  Created by Hayder on 16/10/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) void (^cpmpleCallBack)() ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解除引用1: __weak
//    __weak typeof (self) weakSelf = self;
//    [self loadData:^{
//       
//        NSLog(@"%@",weakSelf.view);
//    }];
    
    //解除引用2: __unsafe_unretained
    //高级iOS 程序员如果需要自行管理内存，可以考虑使用，但是不建议使用
    __unsafe_unretained typeof (self) weakSelf = self;
    
    //EXC_BAD_ACCESS 坏内存访问，野指针访问
    //__unsafe_unretained 同样是 assign 的引用(MRC中没有weak)
    //在MRC中如果要弱引用对象，都是使用assign,不会使用引用计数，但是一旦对象被释放，地址不会改变，继续访问，出现野指针
    //在ARC weak,本质上是一个观察者模式，一旦发现对象被释放，会自动将地址设置为nil,更加安全
    //效率: weak 的效率会略微差一些!
    [self loadData:^{
        
        NSLog(@"%@",weakSelf.view);
    }];
}

- (void)loadData:(void (^)())completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        //使用属性记录block
        self.cpmpleCallBack = completion;
        NSLog(@"耗时操作");
        
        [NSThread sleepForTimeInterval:2.0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //执行block
            completion();
        });
        
    });
}

@end
