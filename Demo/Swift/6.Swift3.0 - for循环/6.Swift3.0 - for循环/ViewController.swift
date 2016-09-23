//
//  ViewController.swift
//  6.Swift3.0 - for循环
//
//  Created by WZH on 16/9/23.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        Demo1()
    }
    
    //逆序遍历
    func Demo2() {
        
        //reversed 反转
        for i in (0..<10).reversed() {
            
            print(i)
        }
        
    }
    
    /**
    swift对语法要求非常严格，尤其是空格
     */
    func Demo1()  {
        
        //变量 i 在 [0,5)循环
        for i in 0..<5 {
            
            print(i)
        }
        
        for i in 0...5 {
            
            print(i)
        }
        
        //提示:范围定义是一个固定的格式，一定要注意空格
        //可计算的闭区间
        //CountableClosedRange<Int>
        let r1 = 0...5
        
        //可计算的区间
        // CountableRange<Int>
        let r2 = 0..<5
        
    }
    
    func Demo() {
        
        //传统的for写法，在swift3.0中被取消
        //i++ / ++i 从swift3.0 被取消
        //i += 1
        // i++ 会多一个临时变量
        //num = i++
        //等价于
        // temp = i
        // num = temp
        // i = temp + 1
        
        //num = ++i
        //等价于
        //i = i + 1
        //num = i
       // for var i = 0; i < 10; i +=1
        //{
            
        //}
    }

}

