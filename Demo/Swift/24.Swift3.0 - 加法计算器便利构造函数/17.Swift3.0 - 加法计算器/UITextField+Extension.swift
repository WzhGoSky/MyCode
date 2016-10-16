//
//  UITextField+Extension.swift
//  17.Swift3.0 - 加法计算器
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

//extension 类似于 OC中的 category
extension UITextField{
    
    convenience init(frame: CGRect, placeholder: String, fontSize: CGFloat = 14)
    {
        //实例化对象
        self.init(frame: frame)
        
        //访问属性
        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}
