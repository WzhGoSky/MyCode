//
//  NSObject+keyValues.m
//  objectKeyValues
//
//  Created by WZH on 16/8/12.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "NSObject+keyValues.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (keyValues)

- (NSDictionary *)modelToKeyValues
{
    //1.获取对象属性列表
    unsigned int propertyNum = 0;
    objc_property_t *propertylist = class_copyPropertyList([self class], &propertyNum);
    
    //2.遍历属性列表
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i=0; i < propertyNum; i++) {
        
        //2.1获得属性名 类型
        objc_property_t property = propertylist[i];
        const char *propertyName = property_getName(property);
        const char *arrtributeName = property_getAttributes(property);
        NSString *className = [NSString stringWithUTF8String:arrtributeName];
        NSArray *compontents = [className componentsSeparatedByString:@"\""];
        Class cls = NSClassFromString(compontents[1]);
        //2.2根据属性名获取getter方法
        SEL getter = sel_registerName(propertyName);
        
        if ([self respondsToSelector:getter]) {
            
            id value = ((id (*) (id,SEL)) objc_msgSend)(self, getter);
            
            NSLog(@"%@",value);
            
            //2.2.1判断value是不是model
            
            if ([self isCustomClass:cls] && value) {
                
                value = [value modelToKeyValues];
            }
            
            if (value) {
                
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setObject:value forKey:key];
            }
        }
    }
    
    free(propertylist);
    
    return dict;
}

- (void)setKeyValues:(NSDictionary *)keyValues
{
    objc_setAssociatedObject(self, @"keyValues",[self modelToKeyValues], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)keyValues
{
    return objc_getAssociatedObject(self, @"keyValues");
}


/**
 *  是否是自定义的类
 */
- (BOOL)isCustomClass:(Class) cls
{
    NSBundle *mainB = [NSBundle bundleForClass:[cls class]];
    if (mainB == [NSBundle mainBundle]) {
        
        return YES;
    }else
    {
        return NO;
    }
}
@end
