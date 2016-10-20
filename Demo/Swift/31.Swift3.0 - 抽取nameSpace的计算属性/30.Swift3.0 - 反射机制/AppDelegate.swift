//
//  AppDelegate.swift
//  30.Swift3.0 - 反射机制
//
//  Created by WZH on 16/10/20.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //window 可选
    var window: UIWindow?

    /**
        1.知道 Swift中有命名空间
         在同一个命名空间下，全局共享
         第三方框架使用Swift，如果直接拖拽到项目中，从属于同一个命名空间，很有可能冲突
        2.重点Swift中，NSClassFromString(反射机制)的写法
        - 反射最重要的目的，就是为了解耦
        - 搜索“反射机制和工厂方法”
        
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        //代码中的？都是可选解包，发送消息
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        //设置 根控制器，需要添加命名空间 -> 默认是项目名称（最好不要有数字和特殊符号）
//        let className = Bundle.main.nameSpace()+"."+"ViewController"
        //利用计算型属性-从阅读上，计算型属性更加直观
        let className = Bundle.main.nameSpace+"."+"ViewController"
        //AnyClass? -> 视图控制器的类型
        let cls = NSClassFromString(className) as? UIViewController.Type
        
        //使用类创建视图控制器
        let vc = cls?.init()
        
//        let vc = ViewController()
        
        self.window?.rootViewController = vc
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

