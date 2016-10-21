//
//  Demolabel.swift
//  29.Swfit3.0 - Swift setter设置数据
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class Demolabel: UILabel {

    var person: Person?{
        
        // 就是替代OC中重写Setter方法
        //区别，再也不需要考虑 _成员变量 = 值！
        //OC中如果是copy属性，应该 _成员变量 = 值.copy
        didSet{
            
            //此时name属性已经有值，可以直接使用设置UI内容!
            text = person?.name
        }
    }
    
    //反射机制的概念
    // 对于任意一个类，都能够知道这个类的所有属性和方法
    // 对于任意一个对象，都能够调用它的人一个方法和属性
    // 这种动态获取的信息以及动态调用对象的方法的功能成为 java语言的反射机制
    
    //OC中如何利用反射机制
//    ~ 利用NSClassFromString 使用字符串获取类（重要）
//    ~ 利用isMemberOfClass 是否是某一个类
//    ~ 利用isKindOfClass 是否是某一个类的子类
//    ~ 利用performSelector 或者 objc_msgSend 间接调用方法
    
    
}
