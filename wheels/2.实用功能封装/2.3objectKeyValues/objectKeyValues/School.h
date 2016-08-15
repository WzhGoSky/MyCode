//
//  School.h
//  objectKeyValues
//
//  Created by WZH on 16/8/12.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "student.h"

@interface School : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSNumber *age;

@property (nonatomic, strong) NSArray *st;

//@property (nonatomic, assign) NSInteger inter;
//
//@property (nonatomic, assign) NSUInteger Uinter;
//
//@property (nonatomic, assign) BOOL bo;
//
//@property (nonatomic, assign) double doub;
//
//@property (nonatomic, assign) CGFloat cgfloat;
//
//@property (nonatomic, assign) float f;

@end
