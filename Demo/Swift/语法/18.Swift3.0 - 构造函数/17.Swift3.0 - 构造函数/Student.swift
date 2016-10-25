//
//  Student.swift
//  17.Swift3.0 - 构造函数
//
//  Created by WZH on 16/10/15.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class Student: Person {
    
    var no: String
    
    //重写 person 的构造函数
    override init(){
        
        no = "001"
        
        super.init()
        
    }
}
