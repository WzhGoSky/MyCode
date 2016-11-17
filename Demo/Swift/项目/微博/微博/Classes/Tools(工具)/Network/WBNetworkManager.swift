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
/**
    405错误，不支持的网络请求方法
 
 */
enum WBHttpMethod {
    
    case GET
    case POST
}
//网络管理工具
class WBNetworkManager: AFHTTPSessionManager {

    //静态区/常量区
    //在第一次访问时，执行闭包，并且将结果保存在shared中
    static let shared: WBNetworkManager = {
        
        //实例化对象
        let instance = WBNetworkManager()
        
        //设置响应的反序列化数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
    }()
    
    
    /// 用户账户的懒加载属性
    lazy var userAccount = WBUserAccount();
    
    ///用户登录标记
    var userLogin: Bool {
        
        return userAccount.access_token != nil
    }

    ///负责处理token
    ///
    /// - Parameters:
    ///   - method: GET/POST
    ///   - urlString: URLstring
    ///   - params: 参数字典
    ///   - name: 上传文件使用的字段名。默认为nil,就不是上传文件
    ///   - data: 上传文件的二进制数据，默认为nil,不上传文件
    ///   - compeletion: 完成回调
    func tokenRequest(method: WBHttpMethod = .GET,urlString: String, params: [String : AnyObject]?,name: String? = nil,data: Data? = nil, compeletion: @escaping ((_ json: AnyObject?, _ isSuccess: Bool) ->())) {
        
        //Token是否为空,程序执行过程中，一般token不会为nil
        guard let token = userAccount.access_token else {
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
            
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
        
        //判断name和data
        if let name = name, let data = data {
            //上传文件
            upload(urlString: urlString, params: params, name: name, data: data, compeletion: compeletion)
        }
        
        request(method: method, urlString: urlString, params: params, compeletion:compeletion)
    }
    
    ///MARK 封装AFN上传方法
    ///封装 AFN 的 GET / POST 请求
    ///上传文件必须是POST方法，GET只能获取数据
    /// - Parameters:
    ///   - urlString: URLString
    ///   - params: 参数字典
    ///   - name: 接收上传数据的服务器字段 新浪微博的为 pic
    ///   - data: 要上传的二进制数据
    ///   - compeletion: 完成回调
    func upload(urlString: String, params: [String : AnyObject]?,name:String,data: Data,compeletion:@escaping ((_ json: AnyObject?, _ isSuccess: Bool) ->())){
        
        
        post(urlString, parameters: params, constructingBodyWith:{(forData) in
            
            //FIXME 创建formData
            /**
                1.data:要上传的二进制数据
                2.name:服务器接受数据的字段
                3.fileName:保存在服务器的文件名
                4.mimeType: 告诉服务器上传文件的类型，如果不想告诉，可以使用application/octet-stream
             */
            forData.appendPart(withFileData: data, name: name, fileName: "xxx", mimeType: "application/octet-stream")
            
        }, progress: nil, success: { (_, json) in
            
             compeletion(json as AnyObject?,true)
            
        }, failure: { (task, error) in
        
            //针对403 处理用户token
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                
                print("token 过期了")
                
                // FIXME:发送通知(本方法不知道被谁调用, 谁接收到处理，谁处理)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "badToken")
            }
            
            print("网络请求错误 \(error)")
            
            compeletion(nil , false)
        })
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
            
            //针对403 处理用户token
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                
                print("token 过期了")
                
                // FIXME:发送通知(本方法不知道被谁调用, 谁接收到处理，谁处理)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "badToken")
            }
            
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

