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
    //初始化并且分配控件，会提前创建
    //移动端开发，“延迟加载”减少内存消耗
    //懒加载 - lazy
    //最大的好处 ->解除解包烦恼
//    lazy var label: DemoLabel =  DemoLabel()
    
    //懒加载本质上是一个闭包
    //完整写法： 供参考 不建议这么写
    //{}包装代码  （）执行代码
    lazy var label = { () -> DemoLabel in
        
        let l = DemoLabel()
        
        //设置label的属性
        
        return l
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        
        
        //2.添加到视图
        //! 解包，为了参与计算， addSubView，用subviews 数组记录空间，数组中不允许加入nil
        //? ---- 可选解包，调用方法，如果为nil，不调用方法，但是不能参与计算
        view.addSubview(label)
        
        label.text = "hello"
        label.sizeToFit()
        label.center = view.center
    }


}

