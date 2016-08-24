//
//  skillProxy.h
//  NSProxy
//
//  Created by Hayder on 16/8/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "flySkill.h"
#import "swimSkill.h"

@interface skillProxy : NSProxy<flySkillDelegate,swimSkillDelegate>

+ (instancetype)dealerProxy;

@end
