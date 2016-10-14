//
//  ViewController.swift
//  13.Swfit3.0-函数的定义
//
//  Created by Hayder on 16/10/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Swift1.0 : sum(10,50)，所有形参都会省略
        //Swift2.0 ： sum(10, y: 50),第一个形参的名称省略
        //Swift3.0 调用方式
//        print(sum(x: 5, y: 5))
        
        //外部参数
        print(sum1(num1: 30, num2: 20))
        
        //测试默认值
        print(sum3())
        print(sum3(x: 10, y: 20))
        print(sum3(x: 10))
        print(sum3(y: 10))
    }
    
    //MARK：- 无返回值
    /**
        知道就行，主要用在闭包。
     - 直接省略
     - ()
     - void
     */
    
    func demo1() {
        
        print("哈哈")
    }
    
    //   前面执行  ->(输出) 目标
    func demo2() -> () {
        print("hehe")
    }
    
    func demo3() -> Void {
        
        print("嘻嘻")
    }
    //MARK: - 默认值
    //通过给参数设置默认值，在调用的时候就可以组合参数，如果不能指定的，就可以使用默认值 
    //OC 中需要定义很多的方法每一集方法的实现，最终调用包含所有参数的那个函数
    func sum3(x: Int = 1, y: Int = 2) -> Int {
        
        return x + y
    }
    
    //MARK:- 外部参数
    //-外部参数就是在形参前面加一个名字
    //-外部参数不会影响函数内部的细节
    //-外部参数会让外部调用方法看起来更加的直观
    //- 外部参数如果使用_,在外部调用函数时，会忽略形参的名字
    func sum2(_ x:Int,_ y: Int) -> Int {
        
        //在 Swift 中 _就是可以忽略任意不感兴趣的内容
        /// Immutable value 'i' was never used; consider replacing with '_' or removing it
        for _ in 0..<10 {
            
            print("hello world")
        }
        
        
        return x + y
    }
    
   
    func sum1(num1 x:Int,num2 y: Int) -> Int {
        
        return x + y
    }
    //MARK:- 函数定义
    /// 函数定义 格式 函数名(形参列表) -> 返回值类型
    ///
    /// - parameter x: 参数一
    /// - parameter y: 参数二
    ///
    /// - returns: 返回值
    func sum(x:Int, y: Int) -> Int {
        
        return x + y
    }

}

