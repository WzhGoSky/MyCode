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
    
    ///访问令牌，所有网络请求，都给此令牌(登录除外)
    var accessToken: String? = "2.00c54PZG8Tsb9Cedbb0b6f96qvNt5E"
    
    
    func tokenRequest(method: WBHttpMethod = .GET,urlString: String, params: [String : AnyObject]?,compeletion: @escaping ((_ json: AnyObject?, _ isSuccess: Bool) ->())) {
        
        //Token是否为空
        guard let token = accessToken else {
            
            compeletion(nil, false)
            
            return
        }
    
        //处理token字典
        var params = params
        if params == nil{
            
            //实例化字典
            params = [String : AnyObject]()
        }
        
        //代码在此处一定有值
        params!["access_token"] = token as AnyObject?
        
        request(method: method, urlString: urlString, params: params, compeletion:compeletion)
    }
    //使用一个函数分装AFN的get和post请求
    /// 封装AFN GET / POST请求
    ///
    /// - Parameters:
    ///   - method:  GET/POST
    ///   - urlString: URLString
    ///   - params: 参数字典
    ///   - compeletion: 完成回调[json / nil]
    func request(method: WBHttpMethod = .GET,urlString: String, params: [String : AnyObject]?,compeletion:@escaping ((_ json: AnyObject?, _ isSuccess: Bool) ->()))
    {
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any?)->() in
            
            compeletion(json as AnyObject?,true)
        }
        
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error)->() in
            
            print("网络请求错误 \(error)")
            
            compeletion(nil , false)
        }
        
        if method == .GET{
            
            get(urlString, parameters: params, progress: nil, success: success, failure: failure)
        
        }else
        {
            post(urlString, parameters: params, progress: nil, success: success, failure: failure)
        
        }
    }
    
}

