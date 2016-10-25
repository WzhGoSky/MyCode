
//
//  Person.swift
//  23.Swift3.0 - 便利构造函数
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

//便利构造函数
//目的: 判断条件，只有满足条件，才实例化对象，可以防止造成不必要的内存开销
//简化对象的创建
//本身不负责属性的创建和初始化工作

//实现的时候加
class Person: NSObject {
    
    var name: String?
    var age: Int = 0
    
    /**
     1. 便利构造函数允许返回nil
        - 正常的构造函数一定会创建对象
        - 判断给定的参数是否符合条件，如果不符合条件，直接返回nil,不会创建对象，减少内存开销
     2.遍历构造函数中使用“self.init()” 构造当前对象
    - 没有 convenience 关键字的构造函数是负责创建对象的，反之是用来检查条件的，本身不负责对象的创建
     3.如果要在遍历构造函数中使用当前对象的属性，一定要在self.init之后
     */
   convenience init?(name: String, age: Int) {
        
        if age > 100 {
            
            return nil
        }
    
    //Use of 'self' in property access 'name' before self.init initializes self
    //使用self访问name之前需要调用self.init
    //实例化当前对象
     self.init()
    
    //执行到此self 才允许被访问，才能够访问到对象的属性
     self.name = name
    }
    
    // 没有func -> 不让调用
    // 没有 () -> 不让重载,不许带参数
    //在对象被销毁钱自动调用
    //类似于OC的dealloc
    deinit {
        
        //1.跟踪对象的销毁
        //2.必须释放 
        /**
            - 通知，不释放不会崩溃，但是崩溃
            - KVO，不释放会崩溃
            - NSTimer/ CADisplayLink
         */
    }
}
