//
//  ViewController.swift
//  17.Swift3.0 - 构造函数
//
//  Created by WZH on 16/10/15.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

/**
 在Swift中，默认同一个项目中（同一个命名空间下），所有类都是共享的，可以直接访问，不需要 import,所有对象的属性 var,也可以直接访问到
 使用cocapods 可以保证类，方法在不同的命名空间下。
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //实例化 person
        //() -> alloc /init
        //Swift中，所有类都默认有一个命名空间，就是项目名称。
        //作用: 给成员变量分配空间，初始化成员变量
        let p = Person()
        
        print(p)
        
        let s = Student()
        
        print("\(s.name)-----\(s.no)")
        
    }

}

