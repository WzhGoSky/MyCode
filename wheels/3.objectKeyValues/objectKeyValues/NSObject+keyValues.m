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

- (NSDictionary *)keyValues
{
    return  ((id (*) (id,SEL)) objc_msgSend)(self, @selector(modelToKeyValues));
}


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
        
        //2.2根据属性名获取getter方法
        SEL getter = sel_registerName(propertyName);
        
        if ([self respondsToSelector:getter]) {
            
            const char *arrtributeName = property_getAttributes(property);
            NSString *className = [NSString stringWithUTF8String:arrtributeName];
            NSArray *compontents = [className componentsSeparatedByString:@"\""];
            if (compontents.count == 3) { //对象类型
                
                Class cls = NSClassFromString(compontents[1]);
                id value = ((id (*) (id,SEL)) objc_msgSend)(self, getter);
                
                //2.2.1判断value是不是model
                if ([self isCustomClass:cls] && value) {
                    
                    //递归
                    value = [value modelToKeyValues];
                }
                
                
                if (value) {
                    
                    NSString *key = [NSString stringWithUTF8String:propertyName];
                    [dict setObject:value forKey:key];
                }
            }else //基本类型
            {
//                NSLog(@"数据中有不能识别的基本数据类型");
                id value  = nil;
                NSLog(@"propertyName ------%@ className---%@",[NSString stringWithUTF8String:propertyName],className);
                NSString *valueType = [className substringWithRange:NSMakeRange(1, 1)];
                
                Ivar var = class_getInstanceVariable([self class], propertyName);
                
//                if ([valueType isEqualToString:@"q"]) { //NSInter
//                    
//                    value = [NSNumber numberWithBool:];
//                    
//                }else if([valueType isEqualToString:@"Q"]) //NSUInter
//                {
//                    
//                }else if([valueType isEqualToString:@"B"])
//                {
//                    
//                }else if([valueType isEqualToString:@"d"])
//                {
//                    
//                }else if([valueType isEqualToString:@"f"])
//                {
//                    
//                }else
//                {
//                    value = [NSNull null];
//                }
                
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setObject:value forKey:key];
            }
        }
    }
    
    free(propertylist);
    
    return dict;
}

//字典转模型
+ (instancetype)objectWithKeyValues:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    unsigned int ivarsNumber = 0;
    
    //获取成员变量列表
    Ivar *ivars = class_copyIvarList([self class], &ivarsNumber);
    
    for(int i=0; i<ivarsNumber; i++)
    {
        Ivar ivar = ivars[i];
        
        //获取成员属性名（带_）
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取不带_的成员属性名作为key值
        NSString *key = [ivarName substringFromIndex:1];
        
        id value = dict[key];
        
        if ([value isKindOfClass:[NSDictionary class]]) //还是字典
        {
            //获取成员属性的类名 生成类对象
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            //处理字符串 @"@\"student\""
            NSRange range = [type rangeOfString:@"\""];
            type = [type substringFromIndex:range.location + range.length];
            range = [type rangeOfString:@"\""];
            type = [type substringToIndex:range.location];
            
            Class modelclass = NSClassFromString(type);
            
            if (modelclass) {
                
                //字典转模型
                value = [modelclass objectWithKeyValues:value];
                
            }
            
        }
        
        if([value isKindOfClass:[NSArray class]])
        {
            if (self.classArr) {
                id idSelf = self;
                //获取数组中字典对应的模型
                NSArray *types = [idSelf classArr];
                NSString *type = [types valueForKey:key];
                
                //生成模型类
                Class classModel = NSClassFromString(type);
                NSMutableArray *modelArr = [NSMutableArray array];
                
                for (NSDictionary *dict in value) {
                    
                    id model = [classModel objectWithKeyValues:dict];
                    [modelArr addObject:model];
                }
                
                value = modelArr;
            }
        }
        
        //赋值属性
        if (value) {
            
            [obj setValue:value forKey:key];
        }
    }
    
    
    return obj;
}

+ (void)arrayObjectClass:(modelClassBlock)modelClassBlock
{
    if (modelClassBlock) {
        
        objc_setAssociatedObject(self, @"classArr", modelClassBlock(), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else
    {
        objc_setAssociatedObject(self, @"classArr", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSArray *)classArr
{
    return objc_getAssociatedObject(self, @"classArr");
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
