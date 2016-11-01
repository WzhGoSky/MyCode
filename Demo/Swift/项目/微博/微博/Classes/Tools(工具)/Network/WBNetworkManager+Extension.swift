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
    func statusList(completion:@escaping (_ list: [[String : Any]]?, _ isSuccess: Bool)->()) {
        
        //用网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        tokenRequest(urlString: urlString, params: nil, compeletion: {(json, isSuccess) -> () in
            
            //如果as?失败, result == nil
            let result = json?["statuses"] as? [[String: Any]]
            
            completion(result, isSuccess)
            
        })
    }
    
}
