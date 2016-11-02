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
    
}
