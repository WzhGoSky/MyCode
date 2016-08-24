//
//  skillProxy.m
//  NSProxy
//
//  Created by Hayder on 16/8/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "skillProxy.h"
#import <objc/runtime.h>

@interface skillProxy()
{
    flySkill   *_fly;
    swimSkill  *_swim;
    NSMutableDictionary *_methodsMap; //方法映射
}
@end

@implementation skillProxy

+ (instancetype)dealerProxy
{
    return [[skillProxy alloc] init];
}

- (instancetype)init
{
    _fly = [[flySkill alloc] init];
    _swim = [[swimSkill alloc] init];
    _methodsMap = [NSMutableDictionary dictionary];
    
    //映射target及其方法名
    [self methodMapWithTarget:_fly];
    [self methodMapWithTarget:_swim];
    
    return self;
}

- (void)methodMapWithTarget:(id)target
{
    unsigned int numbersOfMethods = 0;
    
    //获取target的方法列表
    Method *method_list = class_copyMethodList([target class], &numbersOfMethods);
    
    for (int i=0; i < numbersOfMethods; i++) {
        
        Method temp_method = method_list[i];
        SEL temp_sel = method_getName(temp_method);
        const char *temp_method_name = sel_getName(temp_sel);
        [_methodsMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    }
    
    free(method_list);
}

#pragma mark ------------------------NSProxy------------------------
//消息转发机制
//1.resolveInstanceMethod 是否动态添加方法 YES class_addMethod 添加动态方法  返回NO 进入第二步
//2.进入forwardingTargetForSelector 用于指定哪个对象响应这个方法 返回某个对象就会调用该对象的方法。如果返回的是空，就会调用第三步

////3.方法签名 返回方法的前面不为空就会调用 forwardInvocation
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSString *methodName = NSStringFromSelector(sel);
    
    id target = _methodsMap[methodName];
    
    //检查target
    if (target && [target respondsToSelector:sel]) {
        
        return [target methodSignatureForSelector:sel];
        
    } else {
        
        return [super methodSignatureForSelector:sel];
    }
    
}

/**
    4.调用forwardInvocation之前会先调用methodSignatureForSelector 有方法签名 就会调用forwardInvocation
 */
- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL sel = invocation.selector;
    
    NSString *methodName = NSStringFromSelector(sel);
    
    id target = _methodsMap[methodName];
    
    if (target && [target respondsToSelector:sel]) {
        
        [invocation invokeWithTarget:target];
    }else
    {
        [super forwardInvocation:target];
    }
    
}

//如果第三，第4步没有得到响应，整个代码就会crash

@end
