//
//  WBBaseViewController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    lazy var navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var navItem : UINavigationItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        //2.设置UI
        setUpUI()
    
    }
    
    override var title: String?{
        
        didSet{
            
            navItem.title = title
        }
    }
    
    
    
}

extension WBBaseViewController {
 
    func setUpUI(){
    
        view.backgroundColor = UIColor.cz_random()
        
        //添加导航条
        view.addSubview(navBar)
        
        //设置item
        navBar.items = [navItem]
        
        navBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray];
        
    }
    
}
