

//
//  Person.swift
//  21.Swift3.0 - runtime加载属性列表
//
//  Created by WZH on 16/10/16.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String?
    var age: Int = 0
    
    //基本数据类型，在OC中没有可选，如果定义成可选，运行时同样获取不到，使用KVC就会崩溃
    var age1: Int?
    
    //private 的属性，使用运行时，同样获取不到属性(可以获取到ivar),同样会使KVC崩溃
    private var title: String?
    
    //目标使用使用运行时获取当前类所有属性的数组
    //获取ivars 列表是所有第三方框架字典转模型的基础！
    class func propertylist() -> ([String]){
        
        var count: UInt32 = 0
        //1.获取“类”的属性列表
        //outCount: UnsafeMutablePointer<UInt32>! 可变的
        let list = class_copyPropertyList(self, &count)
        
        print("属性的数量 \(count)")
        
        var result: [String] = []
//        //遍历数组 强行解包
//        for i in 0..<Int(count){
//            
//            //3.根据下标获取属性
//            //objc_property_t?
//            let pty = list?[i] //从可选的数组中提取对应的结果，可能为nil
//        
//            //获取属性名称的C语言字符串
//            //Int8 -> Byte ->Char -> C语言字符串
//            let cName = property_getName(pty!) //需要用属性获取名称，这个属性必须存在，就使用了强行解包！
//            
//            //5.转换成String 的字符串
//            let name = String(utf8String: cName!)//必须用C语言字符串转换成String
//        
//            result.append(name!)
//            
//        }
        //遍历数组
        for i in 0..<Int(count){
            
            //3.根据下标获取属性
            //使用 guard 语法，依次判断每一项是否有值，如果一项为nil，就不再执行后续代码
            guard let pty = list?[i],
                 let cName = property_getName(pty),
                 let name = String(utf8String: cName)
            else {
                
                //继续访问下一个
                continue
            }
            
            //name 一定有值
            result.append(name)
        }

        //3.释放C语言对象
        free(list)
    
        return result
    }
}
