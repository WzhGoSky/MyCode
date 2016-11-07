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
 
 关于表格的性能优化
 
 - 尽量少计算，所有需要的素材提前计算好
 - 控件上不要设置圆角半径，所有图像渲染属性，都要注意
 - 不要动态创建控件，所有需要的控件，都要提前创建好，在显示的时候根据数据隐藏/显示、
 - cell的控件的层次越少越好，数量越少越好
 */

class WBStatusViewModel: CustomStringConvertible {
    
    var status: WBStatus
    
    //存储型属性(用内存换CPU)
    var memberIcon: UIImage?
    
    
    /// 构造函数
    init(model: WBStatus) {
        
        self.status = model
        
        //common_icon_membership_level1
        //会员等级
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)!<7{
            
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            
            memberIcon = UIImage(named: imageName)
            
        }
    }
    
    var description: String{
        
        return status.description
    }
}
