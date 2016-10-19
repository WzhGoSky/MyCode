//
//  ViewController.swift
//  26.Swift3.0 - 懒加载
//
//  Created by WZH on 16/10/19.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //只是定义，没有分配空间和初始化
    
    //什么时候用as转换 -> 父类转换为子类
    var label: DemoLabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setIp() {
        
        //1.创建空间
        label = DemoLabel()
        
        //2.添加到视图
        //! 解包，为了参与计算， addSubView，用subviews 数组记录空间，数组中不允许加入nil
        //? ---- 可选解包，调用方法，如果为nil，不调用方法，但是不能参与计算
        view.addSubview(label!)
        
        label?.text = "hello"
        label?.sizeToFit()
        label?.center = view.center
    }


}

