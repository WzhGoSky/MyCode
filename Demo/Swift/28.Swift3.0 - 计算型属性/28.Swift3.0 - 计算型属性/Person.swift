//
//  Person.swift
//  28.Swift3.0 - 计算型属性
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    //getter & setter  仅供演示，日常开发不用
    
   private var _name : String?
    
    //Swift中不会重写 getter 和 settter  方法
    var name: String? {
        
        get{
            
            //返回成员变量
            return _name
        }
        
        set{
            
            _name = newValue
        }
    }
    
    //OC中定义属性的时候，有一个readOnly -> OC中 重写getter方法
    var title: String {
        
        //只重写了getter方法,没有重写setter方法，就是readOnly属性
        get{
            
            return "Mr." + (name ?? "")
        }
    }
    
    //只读属性的简写 - 直接return
    //又称为“计算型属性” ->本身不保存内容，都是通过计算获得结果
    //类似于一个函数
    // - 没有参数
    //- 一定有返回值
    var title2: String {
        
        print("name \(name)")
        //直接return 也是只读属性
        return "Mr." + (name ?? "")
    }
    
    
    //懒加载的title,本质是一个闭包
    //懒加载会在第一次访问的时候执行，闭包执行结束后，会把结果保存在title3中
    //后续调用，直接返回内容，不会执行
    //懒加载的属性会分配空间存储值
    //
    lazy var title3: String = {
        
       return "Mr." + (self.name ?? "")
    }()
}
