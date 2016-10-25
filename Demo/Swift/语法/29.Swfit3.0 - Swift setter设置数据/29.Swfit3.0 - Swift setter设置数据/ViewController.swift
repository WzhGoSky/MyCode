//
//  ViewController.swift
//  29.Swfit3.0 - Swift setter设置数据
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Person()
        p.name = "Hayder"
        
        let lable = Demolabel(frame: CGRect(x: 20, y: 40, width: 100, height: 40))
        
        view.addSubview(lable)
        
        //将模型设置给label
        lable.person = p
    }

}

