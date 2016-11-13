//
//  WBComposeViewController.swift
//  微博
//
//  Created by Hayder on 2016/11/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///撰写微博控制器
class WBComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = UIColor.cz_random()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"退出",target: self,action: #selector(close))
    }
    
    @objc fileprivate func close(){
        
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
