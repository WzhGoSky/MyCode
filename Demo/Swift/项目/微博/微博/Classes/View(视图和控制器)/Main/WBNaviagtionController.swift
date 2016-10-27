//
//  WBNaviagtionController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBNaviagtionController: UINavigationController {


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //1.先隐藏系统的导航条
        navigationBar.isHidden = true;
        
    }
    /// 重写Push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true;
            
            //设置返回
            if let vc = viewController as? WBBaseViewController {
                
                var title = "返回"
                
                if childViewControllers.count == 1 {
                    
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popTpParent), isBackButton:true)
            }

        }
        
        
        super.pushViewController(viewController, animated: animated);
    }
    
    @objc private func popTpParent(){
        
        popViewController(animated: true)
    }

}
