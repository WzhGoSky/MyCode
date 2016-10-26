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
    
    @objc fileprivate func push(){
    
        let friends = WBDemoViewController()
        
        navigationController?.pushViewController(friends, animated: true);
    
    }
}

extension WBHomeViewController{
    
    override func setUpUI(){
        
        super.setUpUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(push))
        
    }
}
