//
//  ViewController.swift
//  2.Swift3.0-可选项
//
//  Created by Hayder on 16/9/20.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Demo()
    }
    
    func Demo1() {
        
        //1>定义 y,没有初始化
        let y: Int?
        
        //2>给常量设置数值，初始化的工作能做一次
        y = 20;
        
        
        print(y)
        
        
        // *** var 的可选值默认为nil
        // *** let 的可选值没有默认值
        
        var x: Int?
        
        x = 10
        x = 100
        
        print(x)
        
    }
    //最常见的错误
    //unexpectedly found nil while unwrapping an Optional value
    //在解包的时候发现了nil值
    /**
        定义 可选项使用 ‘?’
        解包使用 ‘！’，准备计算
     */
    func Demo() {
        
        //1.原始的可选项定义
        //none 没有值，或者 some 某一类值
        let x: Optional = 10
        
        //2.简单定义
        //'?' 用来定义y是一个可选的Int类型，可能没有值，也可能是一个整数
        // 常量y 使用之前必须初始化
        let y: Int? = 20
        
        //输出结果Optional(10), 提示这是一个可选值
        print(x)
        print(y)
        
        //1> 不同类型之间的值不能直接运算! 如果没有值是 nil 不是任何数据类型，不能参与计算
        //print(x + y)
        //2> "!" 强行解包 - 从可选值中强行获取对应的非空值，如果是nil，就会奔溃
        // 程序员必须为每一个！负责
        // 程序中少用 ！
        print(x! + y!)
    }
}

