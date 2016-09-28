//
//  ViewController.swift
//  3.Swift3.0- 逻辑分支
//
//  Created by Hayder on 16/9/21.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: 三目
    func demo1(){
    
        let x = 10
        
        //三目的语法和OC一样
        x > 5 ? print("大") : print("小")
        
        //'()' 表示空执行
        x > 5 ? print("大") : ()
    }
    func demo() {
    
        let x = 10
        
        /**
            1.条件不需要()
            2.语句必须有{}
         
        */
        if x > 5{
            
            print("大");
        }else
        {
            print("小")
        }
    
    }

}

