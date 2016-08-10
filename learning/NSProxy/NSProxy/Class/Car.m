//
//  Car.m
//  NSProxy
//
//  Created by Hayder on 16/8/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "Car.h"
#import "skillProxy.h"

@implementation Car

- (void)getSkillFromProxy
{
    skillProxy *skill = [skillProxy dealerProxy];
    
    [skill flySkill];
    [skill swimSkill];
    
}
@end
