//
//  AppDelegate.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        window?.rootViewController = WBMainTabbarController()
        
        loadAPPInfo()
        
        return true
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

