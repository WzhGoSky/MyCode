//
//  ViewController.swift
//  20.Swift3.0 - 构造函数KVC
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let p = Person(dict: ["name":"Hayder", "age": 109, "title":"BOSS"])
        
        print("\(p.name) \(p.age)")
        
        let s = Student(dict: ["name":"Hayder", "age": 109, "title":"BOSS","no":"1234"])
        
        print("\(s.name) \(s.no)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

