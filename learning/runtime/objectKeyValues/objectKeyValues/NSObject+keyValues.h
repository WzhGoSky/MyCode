//
//  NSObject+keyValues.h
//  objectKeyValues
//
//  Created by WZH on 16/8/12.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (keyValues)

//@property (nonatomic, strong) NSDictionary *keyValues;

- (NSDictionary *)modelToKeyValues;

@end
