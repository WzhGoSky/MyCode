//
//  WBUserAccount.swift
//  微博
//
//  Created by WZH on 16/11/3.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

/// 用户账户信息
class WBUserAccount: NSObject {
    
    ///访问令牌
    var access_token: String?
    
    ///用户代号
    var uid: String?
    
    ///过期时间 秒
    var expires_in: TimeInterval = 0{
        
        didSet{
            
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    //过期日期
    var expiresDate: Date?
    
    
    override var description: String{
        
        return yy_modelDescription()
    }
    
    
    func saveAccount() {
        
        //1.模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
    
        //删除expires_in
        dict.removeValue(forKey: "expires_in")
        //2.字典序列化 data
        guard  let data = try? JSONSerialization.data(withJSONObject: dict, options: []),let filePath = ("userAccount.json" as NSString).cz_appendDocumentDir() else{
            
            return
        }
        
        //3.写入磁盘
        (data as NSData).write(to:  URL(fileURLWithPath: filePath), atomically: true)
       
        print("用户账户保存成功 \(filePath)")
    }
}
