//
//  ViewController.swift
//  23.Swift3.0 - 便利构造函数
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Person(name: "Hayder", age: 10)
        
        print(p?.name)
        
    }


}

