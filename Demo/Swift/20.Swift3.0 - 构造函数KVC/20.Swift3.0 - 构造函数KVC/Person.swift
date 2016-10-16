//
//  Person.swift
//  20.Swift3.0 - 构造函数KVC
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

/**
 1.定义模型属性的时候，如果是对象，通常都是可选的
- 在需要的时候创建
- 避免写构造函数，可以简化代码
 
 2.如果是基本数据类型，不能设置成可选的，而且要设置初始值，否则KVC会崩溃

 3.如果使用KVC 设置数值，属性不能是private
 4.使用KVC方法之前，应该调用super.init 保证对象实例化完成
 */
class Person: NSObject {
    
    //name 属性是可选的 在OC中很多的属性都是在需要的时候创建
    //例如 vc.view/ tableviewCell.textLabel/detailLabel
    var name: String?
    
    //给基本数据类型属性初始化
    //- 使用KVC会提示无法找到 age 的 KEY
    //- 原因:Int 是一个基本数据类型的结构体， OC中没有，OC中只有基本数据类型！
//    var age: Int? 错误
    
    var age: Int = 0
    
    //- 如果是private 属性，使用KVC 设置值得时候，同样无法设置
    //- 如果设置成private 属性/方法，禁止外部访问
    private var title: String?
    
    
    //重载构造函数，使用字典为本类设置初始值
    init(dict: [String : Any])
    {
        //保证对象已经完全初始化完成
        super.init()
        //Use of 'self' in method call 'setValuesForKeys' before super.init initializes self
        //在使用self 的方法setValuesForKeys 之前必须要先调用super.init
        //KVC的方法是OC方法， 在运行时给对象发送消息
        //要求对象已经实例化完成
        setValuesForKeys(dict)
    }
    
    //重写父类的方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        //没有调用super,将父类的代码实现完全覆盖，不会崩溃
    }
}
