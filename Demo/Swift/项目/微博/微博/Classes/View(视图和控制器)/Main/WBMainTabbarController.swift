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

    //定时器
    fileprivate var timer: Timer?
    //MARK: - 私有控件
   fileprivate lazy var composeButton : UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button");
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChildControllers()
        setUpComposeButton()
        setUpTimer()
        
    }
    
    deinit {
        
        //销毁时钟
        timer?.invalidate()
    }
    /**
        portrait 肖像  竖屏
        landscape 风景 横屏
     
     
     在主控制器里面实现这个方法 主要是因为当前控制器和子控制器都会遵守
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        return .portrait
    }
    //private 能够保证方法私有，仅在当前对象访问
    //@objc 允许这个函数在运行时通过OC的消息机制被调用
    
    @objc fileprivate func composeStatus(){
        
        print("撰写微博")
        
        
        
    }

}

//时钟相关方法
extension WBMainTabbarController{
    
    fileprivate func setUpTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    ///时钟方法
    @objc private func updateTimer(){
     
       
        WBNetworkManager.shared.unreadCount { (count) in
            
             //设置首页tabbarItm的badgeNumber
            self.tabBar.items?[0].badgeValue = count == 0 ? nil : "\(count)"
            
            //设置APP的badgeNumber 从ios8.0之后要用户授权才能显示
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}
//extension  类似于 OC中的分类， 在Swift中 还可以用来切分代码块
//可以把相近似功能的函数，放在一个extension钟
//便于代码的维护
//注意:和 OC 的分类一样， extension 中不能定义属性
extension WBMainTabbarController{
    
   fileprivate func setUpComposeButton(){
        
        tabBar.addSubview(composeButton)
        
        //计算按钮的高度
        let count = CGFloat(childViewControllers.count)
        
        //将向内缩颈的宽度减小，能够让按钮的宽度变大，盖住容错点，防止穿帮
        let width = tabBar.bounds.width / count - 1
        
        //CGRectInset 正数向内缩进
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0);
        
        //按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }
    
    fileprivate  func setUpChildControllers(){
        
        //获取沙盒json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        //判断data是否有内容，没有文件就说明本地沙盒没有文件
        if data == nil {
            
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        //data一定会有值
        
        //从bundle 加载配置的json
        //1、路径 2. 加载，3.反序列化
        //try 知识点 ： 错误处理 throw 抛出异常 
        //try? 如果解析成功，就有值，否则为nil 
        //try！ 如果解析成功就有值， 否则崩溃
        //处理异常,能够接收到错误，并且输出错误
        //但是语法结构复杂，而且{}里面的智能提示很不友好
        /**
         do{
         
            let array = try JSONSerialization.jsonObject(with: data! as Data, options: [])
         }catch{
            
         
         }
         */
        
       guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : Any]]
        else{
        
            return
        } 
        
        var arrayM = [UIViewController]()
        
        for dict in array!
        {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    /// 使用字典创建一个子控制器
    ///
    /// - parameter dict: 信息字典 [claName , title, imageName, visitorInfo]
    // returns : 子控制器
    private func controller(dict:[String : Any]) -> UIViewController{
        
        guard let  claName = dict["clsName"] as? String,
                let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + claName) as? WBBaseViewController.Type,
        let visitorInfo = dict["visitorInfo"] as? [String : String]
            else {
                
                return UIViewController();
        }
        
        //2.创建视图控制器
        //1>将claName 转换成cls
        let vc = cls.init()
        
        vc.title = title
        
        //设置图像
        vc.tabBarItem.image = UIImage(named:"tabbar_" + imageName);
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //设置tabbar的标题字体大小
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12)], for: .normal)
        
        //设置控制器的访客信息字典
        vc.visitorInfo = visitorInfo
        
        let nav = WBNaviagtionController(rootViewController: vc)
        
        return nav;
    
    }
}
