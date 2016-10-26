//
//  WBNaviagtionController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBNaviagtionController: UINavigationController {


    /// 重写Push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true;
        }
        
        super.pushViewController(viewController, animated: animated);
    }
    

}
