//
//  DemoLabel.swift
//  26.Swift3.0 - 懒加载
//
//  Created by WZH on 16/10/19.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class DemoLabel: UILabel {
    
    //重写
    //XIB 不会调用，纯代码调用
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    
    //提示:所有UIView及子类在开发时，一旦重写了构造函数
    //必须要实现 initWithCoder函数，以保证实现两个通道
    required init?(coder aDecoder: NSCoder) {
       
        super.init(coder: aDecoder)
        
        setUpUI()
        
        //注意 如果用XIB/SB开发，会直接崩溃
        //禁止XIB使用本类
    }
    
    private func setUpUI(){
        
        
        
    }
}
