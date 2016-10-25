//
//  ViewController.swift
//  28.Swift3.0 - 计算型属性
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var p = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p.name = "laowang"
        
        print("\(p.name)")
        
        //不能设置值
        //p.title = "老张"
        //不允许修改只读属性
//        p.title2 = "xxx"
        
        print(p.title3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print(p.title2)
    }
}

