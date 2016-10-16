//
//  Person.swift
//  18.Swift3.0 - 重载构造函数
//
//  Created by Hayder on 16/10/15.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
/**
 1.构造函数目的:给自己的属性分配空间并且设置初始值
 2.调用父类构造函数之前，需要先给本类的属性设置初始值
 3.调用父类的构造函数，给父类的属性分配空间设置初始值
 NSObject 没有属性，只有一个成员变量isa
 4.如果重载了构造函数，并且没有实现父类init方法，系统不再提供init()构造函数（默认是会有的）
 因为默认的构造函数，不能本类的属性分配空间
 */
class Person: NSObject {
    
    var name: String
    
    override init(){
        
        name = "Hayder"
        
        super.init()
    }
    
  
    
    //重载，函数名相同，参数和个数不同
    //重载可以给自己的属性从外部设置初始值
    //OC没有重载，只有initWithXXXX
    init(name: String) {
        
        //使用参数的name 设置给属性
        self.name = name
        
        //调用父类的构造函数
        super.init()
    }
    
}
