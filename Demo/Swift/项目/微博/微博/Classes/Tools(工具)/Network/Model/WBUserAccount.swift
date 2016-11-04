//
//  WBUserAccount.swift
//  微博
//
//  Created by WZH on 16/11/3.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

fileprivate let accountFile = "userAccount.json"
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
    
    override init() {
        
        super.init()
        
        //从沙盒加载用户信息
        //从磁盘加载保存的文件
        guard  let path = accountFile.cz_appendDocumentDir(),
            let data = NSData(contentsOfFile: path),
        let dic = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String : AnyObject]else{
            
                print("加载数据失败")
                return
        }
        //使用字典设置属性值
        yy_modelSet(with: dic ?? [:])
        
        //判断 token是否过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            
            print("账户过期")
            
            //清空token
            access_token = nil
            uid = nil
            
            //删除账户文件
            _ = try? FileManager.default.removeItem(atPath: path)
            
        }
        
        
    }
    
    func saveAccount() {
        
        //1.模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
    
        //删除expires_in
        dict.removeValue(forKey: "expires_in")
        //2.字典序列化 data
        guard  let data = try? JSONSerialization.data(withJSONObject: dict, options: []),let filePath = (accountFile as NSString).cz_appendDocumentDir() else{
            
            return
        }
        
        //3.写入磁盘
        (data as NSData).write(to:  URL(fileURLWithPath: filePath), atomically: true)
       
        print("用户账户保存成功 \(filePath)")
    }
}
