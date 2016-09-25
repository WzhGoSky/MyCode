//
//  ViewController.swift
//  8.Swift3.0 - 数组
//
//  Created by WZH on 16/9/23.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: - 数组的遍历
    func demo2()  {
        
        let arr = ["张三","小芳","小羊"];
        
        //1.按照下标遍历
        for i in 0..<arr.count {
            
            print(arr[i])
        }
        
        //2,for in 遍历元素
        print("---- for in 遍历元素")
        
        for s in arr {
            
            print(s)
        }
        
        //3.enum block遍历 ，同时遍历下标和内容
        print("----同时遍历下标和内容 ")
        
        //元组 (offset: Int, element: String)
        for e in arr.enumerated() {
            
            print(e)
        }
        
        //4.遍历下标和内容2
        // n 就是索引下标
        // s 就是[String] 数组 n 对应的 String 元素
        // 其中n/s 的名字可以随便写
        for (n,s) in arr.enumerated() {
            
            print("\(n) ---- \(s)")
        }
        
        //5.反序遍历
        for s in arr.reversed() {
            
            print(s);
        }
        
        //6.反序索引 & 内容(必须是enum在前， reve在后)
        for (n,s) in arr.enumerated().reversed() {
            
             print("\(n) ---- \(s)")
        }
    }
    
    //MARK: - 数组的定义
    func demo1() -> () {
        
        //OC使用[] 定义数组。Swift一样， 但是没有“@”
        //自动推导的结果[String] -> 表示数组中存放的都是String
        //Swift中的基本数据类型不需要包装
        let arr = ["张三","小芳","小羊"]
        
        print(arr)
        
        //CG结构体[CGPoint]
        let p = CGPoint(x: 10, y: 300)
        let arr3 = [p]
        print(arr3)
        
        //混合数组:开发中几乎不用，因为数组是靠下标索引
        //如果数组中的类型不一致，自动推导的结果[NSObject]
        //在Swift中海油一种类型[AnyObject] -> 任意对象
        //在Swift中一个类可以没有任何‘父类’
        //***在混合的数据中，CG机构体需要包装
        let arr4 = ["张三", 1] as [Any]
        print(arr4)
        
        
    }
}

