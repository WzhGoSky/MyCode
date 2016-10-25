//
//  ViewController.swift
//  12.Swift3.0 - Swift与OC区别
//
//  Created by Hayder on 16/9/27.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    /**
         Swift
         
         - 类
         - 结构体
         - 枚举（一般不会用到太高级的语法）
         
         以上三个都有构造函数，都可以有方法，整体看起来，都想原有的类
     
        - 纯代码
     */
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        let btn = UIButton()
        
        btn.setTitle("come on", for: .normal)
        
        //raw，原始的，使用一个值调用枚举的构造函数，创建一个枚举值
        btn.setTitle("come", for: UIControlState(rawValue: 0))
        
        btn.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
        
        btn.sizeToFit()
        btn.center = view.center
        view.addSubview(btn)
        
    }


}

