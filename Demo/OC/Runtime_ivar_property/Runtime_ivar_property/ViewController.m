//
//  ViewController.m
//  Runtime_ivar_property
//
//  Created by WZH on 16/9/9.
//  Copyright © 2016年 limpid. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Person *p = [[Person alloc] init];
//    
//    //1.获取名为“_name”的成员变量
//    Ivar ivar = class_getInstanceVariable([Person class], "_name");
//    //2.设置值
//    object_setIvar(p, ivar, @"Hayder");
//    
//    
//    NSLog(@"%@",object_getIvar(p, ivar));
//    
//    
//    
//    [self getAllIvarsList];
//    
//    [self getAllPropertyList];
    
    [self performSelector:@selector(doSomething)];
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething)) {
    
        class_addMethod([self class], sel, (IMP)addMethod, "v@:");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

void addMethod(id self, SEL _cmd)
{
    NSLog(@"添加方法");
}


- (void)getAllIvarsList
{
    unsigned int number = 0;
    
    Ivar *ivars = class_copyIvarList([Person class], &number);
    
    for (unsigned int i=0; i < number; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        
        NSLog(@"name---%s,type-----%s",name,type);
    }
    
    free(ivars);
}

- (void)getAllPropertyList
{
    unsigned int number = 0;
    
    objc_property_t *propertys = class_copyPropertyList([Person class], &number);
    
    for (unsigned int i=0; i < number; i++) {
        
        objc_property_t property = propertys[i];
        
        const char *name = property_getName(property);//字典转模型里面的key value就是dict[key]
        const char *type = property_getAttributes(property);
        
        NSLog(@"name---%s,type-----%s",name,type);
    }
    
    free(propertys);
}



@end
