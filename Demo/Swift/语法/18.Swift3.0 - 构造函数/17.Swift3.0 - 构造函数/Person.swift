
//
//  Person.swift
//  17.Swift3.0 - 构造函数
//
//  Created by WZH on 16/10/15.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

/**Swift
1.给自己的属性分配空间并且设置初始值
2.调用父类的“构造函数”，给父类的属性分配空间初始值，NSObject 没有属性，只有一个成员变量‘isa’
 
 OC中初始化化过程和Swift相反
 */


//1.Class 'Person' has no initializers
//Person 类没有"初始化器"，构造函数，可以有多个，默认是init
class Person: NSObject {
    
    var name: String
    /**
    必选属性：
    1.非Optional属性，都必须在构造函数中设置初始值，从而保证对象在被实例化的时候，属性都被正确舒适化
    2.在调用父类构造函数之前，必须保证本类的属性都可以完成初始化
    3.Swift中构造函数不用写 func
    4. override 重写
        4.1.父类存在相同的方法
        4.2.子类重新编写父类方法的实现
     */
    
    // 2.Overriding declaration requires an 'override' keyword
    // 重写 -> 父类有这个方法，子类重新实现，需要override 关键字
    
    //3. Property 'self.name' not initialized at implicitly generated super.init call
    //implicitly（隐式生成的）super.init之前，属性 self.name 没有被初始化
    override init() {
        
        name = "Hayer"
        //4.Property 'self.name' not initialized at super.init call
        // 提示给self.name 初始化 -> 分配空间，设置初始值
        super.init()
    }
}
