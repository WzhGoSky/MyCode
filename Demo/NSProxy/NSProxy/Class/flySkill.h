//
//  flySkill.h
//  NSProxy
//
//  Created by Hayder on 16/8/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

//将flySkill中想给car用的属性写成协议
@protocol flySkillDelegate <NSObject>

- (void)flySkill;

@end

@interface flySkill : NSObject


@end
