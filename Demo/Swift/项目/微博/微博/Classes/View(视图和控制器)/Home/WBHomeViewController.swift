//
//  WBHomeViewController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpUI()
    }
    
    @objc fileprivate func myFriend(){
    
        let friends = WBDemoViewController()
        
        navigationController?.pushViewController(friends, animated: true);
    
    }
}

extension WBHomeViewController{
    
    override func setUpUI(){
        
        super.setUpUI()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(myFriend))
    
    }
}
