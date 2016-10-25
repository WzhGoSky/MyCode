//
//  ViewController.swift
//  27.Swift3.0 懒加载和OC的区别
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "hello"
        label.sizeToFit()
        
        //和OC 不同
        //一旦 label 被设置为nil，懒加载也不会被再次执行
        //懒加载的代码智慧在第一次调用的时候，执行闭包，然后将闭包的结果保存在label的属性中
        print(label)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        //Swift中一定注意不要主动的清理视图或者空间
        //因为懒加载不会再次创建 
    }
}

