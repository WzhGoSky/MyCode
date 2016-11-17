//
//  WBEmoticon.swift
//  Emoticon
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit
import YYModel

class WBEmoticon: NSObject {

    ///表情类型 false - 图片表情 / true - emoji
    var type = false
    
    ///表情字符串，发送给新浪微博的服务器
    var chs: String?
    
    ///表情图片名称，用于本地图文混排
    var png: String?
    
    ///emoji的16进制编码
    var code: String?
    
    override var description: String{
        
       return yy_modelDescription()
    }
    
}
