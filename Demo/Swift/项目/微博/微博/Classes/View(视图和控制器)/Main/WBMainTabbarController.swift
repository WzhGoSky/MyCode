//
//  WBMainTabbarController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

//主控制器
class WBMainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChildControllers()
        
    }

}

//extension  类似于 OC中的分类， 在Swift中 还可以用来切分代码块
//可以把相近似功能的函数，放在一个extension钟
//便于代码的维护
//注意:和 OC 的分类一样， extension 中不能定义属性
extension WBMainTabbarController{
    
     func setUpChildControllers(){
        
        let array = [
            ["clsName" : "WBHomeViewController","title" : "首页","imageName":""],
//            ["claName" : "WBHomeViewController","title" : "首页","imageName":""],
//            ["claName" : "WBHomeViewController","title" : "首页","imageName":""],
//            ["claName" : "WBHomeViewController","title" : "首页","imageName":""]
        ]
     
        var arrayM = [UIViewController]()
        
        for dict in array
        {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    /// 使用字典创建一个子控制器
    ///
    /// - parameter dict: 信息字典 [claName , title, imageName]
    // returns : 子控制器
    private func controller(dict:[String : String]) -> UIViewController{
        
        guard let  claName = dict["clsName"],
                let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + claName) as? UIViewController.Type
            else {
                
                return UIViewController();
        }
        
        //2.创建视图控制器
        //1>将claName 转换成cls
        let vc = cls.init()
        
        vc.title = title
        
        let nav = WBNaviagtionController(rootViewController: vc)
        
        return nav;
    
    }
}
