//
//  ViewController.swift
//  1.Swift3.0-变量和常量
//
//  Created by Hayder on 16/9/20.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Dome1()
        
        //关于 var  和 let 的选择
        //不可变的会更加安全，开发的时候，通常会先使用let，在需要变化的时候，再改成var
        
        
        var x = 10
        let y = 20
        
        let v = UIView()
        
        //仅仅修改的是V的属性，并没有修改v的指针地址
        v.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        view.addSubview(v)
        
    }

    //1.定义变量 var，定义之后，可以修改
    // 常量 let, 定义之后，不能修改
    
    //2.自动推导，变量/常量的类型会根据右侧的代码执行结果，推倒对应的类型。
    //热键：option + click
    
    //整数:Int （oc中 NSInteger 类似）
    
    //3.在Swift中对类型要求异常严格
    //***（重要）任何不同类型的数据之间，不允许直接运算
    //不会做默认的隐式的转换，所有的类型确定，都要由程序员负责。
    
    //4.Swift中，不存在基本数据类型，都是结构体
    func Dome1() {
        
        let x = 10
        let y = 10.5
        
        //1. 将y装换成整数
        //OC中的写法（int）y - > 类型墙砖
        //Swift 中 Int() 结构体的构造函数
        print(x + Int(y))
        
        //2.将 x 转换成Double
        print(Double(x) + y)
        
    }
    func demo() {
        
 
        var x = 10
        x = 20
        
        //小数:Double 精度高
        let y = 10.5
        
        let view = UIView()
        
        print(x)
        print(y)
        print(view)
    }

    func Demo2() {
        
        //如果需要制定变量/常量的类型，也可以直接使用let x : 类型 = 值
        // 提示:在Swift 开发中，极少使用直接制定类型，通常都是自动推导
        let x : Double = 10
        let y = 10.5
        
        print(x + y)
        
        
    }

}

