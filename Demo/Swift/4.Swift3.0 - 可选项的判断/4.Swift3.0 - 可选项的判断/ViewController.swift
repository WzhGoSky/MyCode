//
//  ViewController.swift
//  4.Swift3.0 - 可选项的判断
//
//  Created by Hayder on 16/9/21.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Demo(x: 10, y: nil)
    }
    
    // MARK: - ??
    func Demo1(x: Int?, y: Int?)  {
        
        /**
         ?? 一个简单的三目运算符
         - 如果有值，使用值
         - 如果没有值， 使用？？ 后面的值替代
         */
        print((x ?? 0) + (y ?? 0))
        
        let name : String? = "老王"
        
        print((name ?? "") + "你好")
        
        // ?? 操作符号的优先级‘低’，在使用的时候，一定要加上括号
        print(name ?? "" + "你好")
    }
    
    func Demo(x: Int?, y: Int?) {
        
        //1.强行解包有风险
        //print(x! + y!)
        
        
        //2.使用if判断
        //但是: 如果直接使用if，一不小心，会让代码很丑陋
        if x != nil && y != nil  {
            
            print(x! + y!)
        }else
        {
            print("x 或者 y 为nil")
        }
    }

}

