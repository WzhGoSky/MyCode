//
//  Student.swift
//  18.Swift3.0 - 重载构造函数
//
//  Created by Hayder on 16/10/15.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class Student: Person {
    
    var no: String
    
    init(name: String, no: String) {
        
        self.no = no
        
        //调用父类方法给name初始化
        super.init(name: name) 
    }
    
}
