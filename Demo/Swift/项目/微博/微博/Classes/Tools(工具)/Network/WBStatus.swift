//
//  WBStatus.swift
//  微博
//
//  Created by Hayder on 2016/11/1.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import YYModel

///微博数据模型
class WBStatus: NSObject {
    
    //Int 类型，在64 位机器是64 位， 32位是32位
    //不写 Int64 在部分机器上都无法正常运行
    var id: Int64 = 0
    
    ///微博信息内容
    var text: String?
    
    /// 微博用户
    var user: WBUser?
    
    ///转发数
    var reposts_count: Int = 0
    ///评论数
    var comments_count: Int = 0
    ///点赞数
    var attitudes_count: Int = 0
    
    //重写description的计算型属性
    override var description: String{
        
        return yy_modelDescription()
    }
    
}
