//
//  WBNetworkManager+Extension.swift
//  微博
//
//  Created by Hayder on 2016/11/1.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import Foundation

//MARK: - 分装新浪微博的网络请求方法
extension WBNetworkManager{
    
    //加载微博数据 字典
    func statusList(since_id: Int64 = 0,max_id: Int64 = 0, completion:@escaping (_ list: [[String : Any]]?, _ isSuccess: Bool)->()) {
        
        //用网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        //Swift中 Int 可以转换为AnyObject / 但是Int64 不行
        let params = ["since_id" : "\(since_id)","max_id" : "\(max_id > 0 ? max_id - 1 : 0)"]
        
        tokenRequest(urlString: urlString, params: params as [String : AnyObject]?, compeletion: {(json, isSuccess) -> () in
            
            //如果as?失败, result == nil
            let result = json?["statuses"] as? [[String: Any]]
            
            completion(result, isSuccess)
            
        })
    }
    
    //返回微博的未读数量
    func unreadCount(completion:@escaping ((_ count: Int)->())) {
        
        guard let uid = userAccount.uid else {
            
            return
        }
        
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        
        let params = ["uid" : uid]
        
        tokenRequest(urlString: urlString, params: params as [String : AnyObject]?, compeletion: {(json, isSuccess) -> () in
            
            let dict = json as? [String : AnyObject]
            
            let count  = dict?["status"] as? Int
            
            completion(count ?? 0)
        })
    }
    
}


// MARK: - 用户信息
extension WBNetworkManager{

    ///加载当前用户信息
    func loadUserInfo(completion:@escaping (_ dict: [String : AnyObject])->()) {
        
        guard let uid = userAccount.uid else {
            
            return
        }
    
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["uid": uid]
        
        //发起网络请求
        tokenRequest(urlString: urlString, params: params as [String : AnyObject]?){ (json, isSuccess)->() in
            
            //完成回调
            completion(json as? [String : AnyObject] ?? [:])
            
        }
        
        
    }
}

// MARK: - OAuth相关方法
extension WBNetworkManager{
    
    ///加载AccessToken
    ///
    /// - Parameters:
    ///   - code: 授权码
    ///   - competition: 完成回调
    func loadAccessToken(code: String,competition: @escaping (_ isSuccess: Bool)->()){
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id": WBAppKey,
                      "client_secret": WBAppSecret,
                      "grant_type":"authorization_code",
                      "code": code,
                      "redirect_uri":WBRedirectURI,
                      ]
        
        request(method: .POST, urlString: urlString, params: params as [String : AnyObject]?, compeletion:{(json, isSuccess) in
            
            //直接字典转模型 空字典[:]
            self.userAccount.yy_modelSet(with: (json as? [String: AnyObject]) ?? [:])
            
            print(self.userAccount)
            
            //加载当前用户信息
            self.loadUserInfo(completion: { (dict) in
                
                print(dict)
                
                //使用用户信息字典设置用户账户信息
                self.userAccount.yy_modelSet(with: dict)
                
                //保存模型
                self.userAccount.saveAccount()
                
                //用户信息加载完成再回调
                competition(isSuccess)
            })
        })
        
    }
}
