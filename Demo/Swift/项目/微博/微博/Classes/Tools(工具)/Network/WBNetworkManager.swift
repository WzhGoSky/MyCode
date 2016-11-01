//
//  WBNetworkManager.swift
//  微博
//
//  Created by WZH on 16/11/1.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import AFNetworking

//Swift 的枚举支持任意数据类型
//switch、 enum 在OC中只支持整数
enum WBHttpMethod {
    
    case GET
    case POST
}
//网络管理工具
class WBNetworkManager: AFHTTPSessionManager {

    //静态区/常量区
    //在第一次访问时，执行闭包，并且将结果保存在shared中
    static let shared = WBNetworkManager()
    
    //使用一个函数分装AFN的get和post请求
    func request(method: WBHttpMethod,urlString: String, params:[String : AnyObject]) {
        
        let success = { (task:URLSessionDataTask, json: Any?)->() in
            
        }
        
        let failure = { (task:URLSessionDataTask?, error: NSError)->() in
            
        }
        
        if method == .GET{
            
            get(urlString, parameters: params, progress: nil, success: success, failure: failure)

        }else
        {
            post(urlString, parameters: params, progress: nil, success: success, failure: failure)
        
        }
    }
    
}

