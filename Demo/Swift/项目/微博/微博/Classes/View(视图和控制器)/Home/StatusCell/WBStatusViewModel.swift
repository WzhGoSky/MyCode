//
//  WBStatusViewModel.swift
//  微博
//
//  Created by WZH on 16/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import Foundation
import YYModel

///单条微博
/**
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要
 1.遵守CustomStringConvertible
 2.实现description 计算型属性
 */
class WBStatusViewModel: CustomStringConvertible {
    
    var status: WBStatus
    
    
    /// 构造函数
    init(model: WBStatus) {
        
        self.status = model
        
    }
    
    var description: String{
        
        return status.description
    }
}
