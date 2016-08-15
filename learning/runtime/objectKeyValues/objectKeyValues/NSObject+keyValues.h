//
//  NSObject+keyValues.h
//  objectKeyValues
//
//  Created by WZH on 16/8/12.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSArray *(^modelClassBlock)();

@interface NSObject (keyValues)

//模型转字典
@property (nonatomic, strong, readonly) NSDictionary *keyValues;

//数组中带模型
+ (void)arrayObjectClass:(modelClassBlock)modelClassBlock;
//字典转模型
+ (instancetype)objectWithKeyValues:(NSDictionary *)dict;

@end
