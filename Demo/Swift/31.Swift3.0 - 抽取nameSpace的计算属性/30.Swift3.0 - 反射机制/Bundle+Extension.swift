//
//  Bundle+Extension.swift
//  30.Swift3.0 - 反射机制
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import Foundation

extension Bundle{
 
//    //返回命名空间字符串
//    func nameSpace() -> String {
//        
////       return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//        return infoDictionary?["CFBundleName"] as? String ?? ""
//    }
    
    //计算型属性，和函数类似，没有参数，有返回值
    var nameSpace: String{
        
        return infoDictionary?["CFBundleName"] as? String ?? ""

    }
    
}
