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
        
       // Demo(x: 10, y: nil)
        
        demo2()
        
        demo3()
        
        
    }
    
    func demo4(name: String?, age: Int?) {
        
        if let name = name, let age = age{
        
            //非空的name 和 age 仅在{} 内有效
            print(name + String(age))
            print("------")
        }
        
        
        //guard let & if let 的技巧
        //使用同名的变量接受值，在后续使用的都是非空，不需要解包
        //好处，可以避免起名字的烦恼
        guard let name = name, let age = age else {
            
            print("姓名或者年龄为nil")
            return
        }
        
        print(name + String(age))
    }
    //MARK: - guard 守卫
    func demo3() {
        
        let oName: String? = "老王"
        let oage: Int? = 10
        
        //guard let 守护
        guard let name = oName,
              let age = oage else {
            
            print("姓名或者年龄为nil")
            return
        }
        
        // 代码执行至此，name 和 age 一定有值
        //通常判断是否有值之后，会做具体的逻辑实现，通常代码多
        //如果用if let 凭空多了一层粉质，guard 是降低分支层次的办法
        //guard 的语法是Swift2.0 推出的
        print(name + String(age))
    }
    
    
    //MARK: - if let / var 连用语法,目的就是判断值
    // 不是单纯的if
    func demo2() {
        
        let oName: String? = "老王"
        let oage: Int? = 10
        
        //if let 判断值是否为nil,{}内一定有值，可以直接使用，不需要解包
        //if var 连用，{}可以对值进行修改!
        if let name = oName,
           let age = oage{
            
            //进入分支之后，name 和 age 一定有值，不需要解包
            //name 和 age的作用域尽在()中
            print(name + String(age))
        }else{
            
            print("name 或 age 为 nil")
        }
        
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

