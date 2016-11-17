//
//  WBUser.swift
//  微博
//
//  Created by WZH on 16/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///微博用户模型
class WBUser: NSObject {

    var id: Int64 = 0
    
    var screen_name: String?
    
    var profile_image_url: String?
    
    ///认证类型 -1 没有认证，0 认证用户。2，3，5 企业认证。220：达人
    var verified_type: Int64 = 0
    
    ///会员等级 0-6
    var mbrank: Int = 0
    
    override var description: String{
        
       return yy_modelDescription()
    }
    
    
}
