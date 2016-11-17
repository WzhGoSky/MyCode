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
    
    ///微博创建时间字符串
    var created_at: String?
    
    ///微博来源 - 发布微博使用的客户端
    var source: String?
    ///转发数
    var reposts_count: Int = 0
    ///评论数
    var comments_count: Int = 0
    ///点赞数
    var attitudes_count: Int = 0
    
    ///微博配图模型数组
    var pic_urls: [WBStatusPicture]?
    
    ///被转发的原创微博
    var retweeted_status: WBStatus?
    
    //类函数 -> 告诉第三方框架，如果遇到数组类型的属性，数组中存放的对象是什么类
    class func modelContainerPropertyGenericClass() -> [String : AnyClass]{
        
        return ["pic_urls" : WBStatusPicture.self]
    }
    
    //重写description的计算型属性
    override var description: String{
        
        return yy_modelDescription()
    }
    
}
