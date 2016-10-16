//
//  Person.h
//  Runtime_ivar_property
//
//  Created by WZH on 16/9/9.
//  Copyright © 2016年 limpid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *_ID;
}

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger age;

@end
