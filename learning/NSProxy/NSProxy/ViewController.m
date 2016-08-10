//
//  ViewController.m
//  NSProxy
//
//  Created by Hayder on 16/8/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //NSProxy 负责将消息转发到真正的target的代理类。
    //作用:OC只支持单继承 NSPorxy可模拟多继承
    //理解:假设类A，类B，类C中各有一个方法类D需要使用，但是OC又是单继承，可以利用NSPorxy作为代理，类D去向NSPorxy类中调用。
    //类D是顾客  NSPorxy是经销商 类A，类B，类C是供应商
    
    //
    /**
     *  需要实现方法
     - (void)forwardInvocation:(NSInvocation *)anInvocation;
     - (NSMethodSignature *)methodSignatureForSelector:(SEL)sel;
     */
 
    Car *car = [[Car alloc] init];
    [car getSkillFromProxy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
