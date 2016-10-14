//
//  ViewController.swift
//  14.Swift3.0 - 闭包
//
//  Created by WZH on 16/10/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //类似于OC的block，但比OC的block应用更加的广泛
    //区别: 在OC中block是匿名的函数
    //      在Swift中函数是特殊的闭包
    
    /**
        闭包
        1.提前准备好的代码，在需要的时候执行
        2.可以当做参数传递
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1> 闭包
        //() -> () 没有参数，没有返回值的函数
        //如果没有参数，没有返回值，可以省略，连in一起省略
        let b1 = {
            
            print("hello")
        }
        
        //执行闭包
        b1()
        
        //2. 带参数的闭包
        //(Int) -> ()
        //闭包中，参数，返回值，实现代码都是写在{}中
        //需要使用一个关键字 “in” 分隔定义和实现
        //{ (形参列表 -> 返回值类型 in 实现代码)}
        let b2 = {
            
            (x: Int) -> ()
            
            in
            
            print(x)
        }
        
        b2(100)
        
        //3.带参数/返回值的闭包
        //类型:(Int) -> Int
        let b3 = { (x: Int) -> Int in
            
            return x
        }
        
        print(b3(10))
    }

    func demo() {
        
        print(sum(x:10, y:20))
        
        //1.定义一个常量来记录函数
        let f = sum
        
        //2.在需要的时候执行
        print(f(10, 20))
    }
    func sum(x: Int, y: Int) ->Int{
        
        return x + y
    }
}

