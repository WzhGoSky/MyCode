

//
//  UIButton+Extension.swift
//  17.Swift3.0 - 加法计算器
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(title: String,target:Any?, action: Selector) {
        
        self.init()
        
        self.setTitle(title, for: UIControlState(rawValue : 0))
        self.setTitleColor(UIColor.black, for: .normal)
        self.sizeToFit()
        self.addTarget(target, action: action , for: .touchUpInside)
             
    }
}
