//
//  ViewController.swift
//  5.Swift3.0 - Switch
//
//  Created by Hayder on 16/9/22.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /**
    1.OC中 Switch() 中的值必须是整数
    2.每个语句都需要一个 break
    3.如果要定义局部变量，需要{}
    4.OC中{}可以限定变量的作用域。
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Demo(num: "10")
    }
    
    /**
     1.Swift 可以针对任意类型的值进行分支，不再局限整数
     2.Swift 一般不需要break
     3.Swift 如果需要多值,使用‘,’
     4.所有的分支至少需要一条指令，如果什么都不干，才使用break
     */
    func Demo(num : String){
        
        switch num {
        case "10","9":
            
            print("优")
            
        default:
            print("一般")
        }
        
    }
}

