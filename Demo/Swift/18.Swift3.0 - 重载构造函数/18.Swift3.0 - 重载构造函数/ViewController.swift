//
//  ViewController.swift
//  18.Swift3.0 - 重载构造函数
//
//  Created by Hayder on 16/10/15.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Person()
        
        let p1 = Person(name: "laowang")
        
        
        print("\(p.name)")
    }


}

