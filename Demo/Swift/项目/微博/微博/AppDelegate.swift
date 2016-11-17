//
//  AppDelegate.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //额外设置
        setupAddtions()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        window?.rootViewController = WBMainTabbarController()
        
        loadAPPInfo()
        
        return true
    }

}

///MARK: - 设置APP额外信息
extension AppDelegate{
    
    fileprivate func setupAddtions(){
        
        //1.设置SVProgressHUD最小时间
        SVProgressHUD.setMinimumDismissTimeInterval(2.0)
        
        //2.设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        //3.注册通知
        //#available 监测设备版本 如果是10.0以上
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge,.carPlay], completionHandler: { (success, error) in
                
                print("授权" + (success ? "成功" : "失败"))
            })
        } else { //10.0以下
            
            //iOS8.0 以后取得用户授权显示通知[上方的提示条/声音/badgeNumber]
            let notifySettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
            
        }

    }
    
}
//MARK： -- 从服务器加载应用程序信息
extension AppDelegate{
    
    fileprivate func loadAPPInfo(){
        
        //1.模拟异步
        DispatchQueue.global().async {
            
            //1.url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            
            //2.data
            let data = NSData(contentsOf: url!)
            
            //3.写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            //直接保存在沙盒，等待下一次程序启动使用
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕\(jsonPath)")
            
        }
    }
}

