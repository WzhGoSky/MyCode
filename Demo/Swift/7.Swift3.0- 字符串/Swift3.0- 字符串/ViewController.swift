//
//  ViewController.swift
//  Swift3.0- 字符串
//
//  Created by WZH on 16/9/23.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //string 是一个结构体，性能更高
    //1.string 目前具有绝大多数NSString功能
    //2.string 支持直接遍历
    //NSString 是一个OC对象，性能略差
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - 字符串的子串
    
    func demo4() -> () {
        
        //建议:一般使用NSString 作为中转，因为 Swift 取子串的方法一直在优化
        //更容易理解
        let str = "我们一起飞"
        let ocstr = str as NSString
        
        let s1 = ocstr.substring(with: NSMakeRange(2, 3))
        
        print(s1)
        
        //2.String 的 3.0 方法(语法经常变化)
        //let r = 0..<5
        //str.substring(with: <#T##Range<String.Index>#>)
        //Index
        
        //startIndex position == 0
        str.startIndex
        
        //endIndex position == str.length
        str.endIndex
        
        let s2 = str.substring(from: "我们".endIndex)
        print(s2)
        
        let s3 = str.substring(from: "abc".endIndex)  //"abc, 和 我们 " 都是用来计算长度的
        
        
        //取子字符串的范围
        guard let range = str.range(of: "一起") else {
            
            print("没有找到字符串")
            return
        }
        
        //一定找到范围
        print( str.substring(with: range))
        
    }
    //MARK: - 格式化
    func demo3() -> () {
        
        let h = 8
        let m = 9
        let s = 6
        
        //使用格式字符串格式化
        let dateStr = String(format: "%02d:%02d:%02d", h,m,s)
        print(dateStr)
    }
    //MARK: - 拼接
    //拼接字符串需要注意 可选项 Optional
    func demo2() {
        
        let name = "Hayder"
        let age = 18
        let title: String? = "BOSS"
        let point = CGPoint(x: 100, y: 100)
    
        //\(变量/常量)
        //NSStringFromCGPoint(point)
        let str = "\(name) is \(age) \(title ?? "") \(point)"
        
        print(str)
        
    }
    //MARK:字符串的长度
    func demo1() {
        
        let str = "hello world"
        
        //返回指定编码的对应的字节数量
        //UTF8的编码{0-4个}，每个汉字是3个字节
        print(str.lengthOfBytes(using: .utf8))
        
        //2.字符串长度 -> 返回字符的个数
        print(str.characters.count);
        
        //3.使用NSString 中转
        
        /**
         Swift 中可以使用'值 as 类型' 类型转换
         */
        let ocStr = str as NSString
        print(ocStr.length)
    }
    //MARK: - 字符串的遍历
    func demo() {
        
        // NSString 不支持以下方式遍历
        let str = "hayder"
        
        for c in str.characters {
            
            print(c)
        }
    }
}

