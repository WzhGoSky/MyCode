//
//  ViewController.swift
//  22.Swift3.0 - session使用
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let url = URL(string: "http://www.baidu.com")
       {
        //发起网络请求
        //和OC 的区别，闭包的所有参数需要自己写，OC是直接写入
        // - 如果不关心，可以直接‘_’忽略
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            //            if(error != nil)
            //            {
            //                print("网络请求失败")
            //
            //                return
            //            }
            
            guard let data = data else{
                
                print("网络请求失败")
                return
            }
            
            let html = String(data: data, encoding: .utf8)
            
            print(html)
            
            }.resume()

        }else
       {
            print("url 为nil")
        }
        
        
        
    }

}

