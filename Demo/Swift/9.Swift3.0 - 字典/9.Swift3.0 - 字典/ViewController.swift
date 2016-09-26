//
//  ViewController.swift
//  9.Swift3.0 - 字典
//
//  Created by Hayder on 16/9/26.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        demo2()
    }
    
    //4.合并
    func demo4() {
        
        var dic1 = ["name" : "hayder","age": 10,"title":"老王"] as [String : Any]
        let dic2 = ["name": "大瓜","height": 1.9] as [String : Any]
        
        //将dict2 合并到dict1
        //字典不能直接相加
        
        //思路，遍历 dict 2 依次设置
        //如果 key 存在，会修改
        //如果 key 不存在，不会修改
        for e in dic2
        {
            dic1[e.key] = dic2[e.key]
        }
        
    }
    //3.遍历
    func demo3() {
        
        let dic = ["name" : "hayder","age": 10,"title":"老王"] as [String : Any]
        
        //元组 (key: Sting , value: Any)
        for e in dic {
            
            print("\(e.key),\(e.value)")
        }
        
        print("-----")
        
        /**
        前面的是 KEY
        后面的 是 VALUE
         
        具体的名字可以随便
         */
        for (key, value) in dic
        {
            print("\(key),\(value)")
        }
        
    }
    //2.增删改
    func demo2() {
        
        //可变 var / 不可变 let
        var dic = ["name" : "张","age" : 10] as [String : Any]
        
        //新增 - 如果 KEY 不存在，就是新增
        dic["title"] = "大哥"
        print(dic)
        
        //修改 - 字典中是通过KEY取值，KEY在字典中必须是唯一的
        //如果KEY值存在就是修改
        dic["name"] = "大西瓜"
        print(dic)
        
        //删除 - 直接给定KEY
        // *** 科普，字典是通过 KEY 来定位值的， KEY 必须是可以 'hash 哈希' MD5一种
        //hash 就是将字符串变成唯一的‘整数’，便于查找， 提高字典遍历的素组
        dic.removeValue(forKey: "age")
        print(dic)
        
    }
    //1.定义
    func demo1() {
        
        //OC 定义字典使用{}
        //Swift中使用[]
        
        //[KEY: VALUE] -> [String : Any]
        let dic = ["name" : "张","age" : 10] as [String : Any]
        
        print(dic)
        
        //定义字典的数组
        let array:[[String : Any]] = [
            
            ["name" : "张","age" : 10],
            ["name" : "张","age" : 10]
        ]
        
    }

}

