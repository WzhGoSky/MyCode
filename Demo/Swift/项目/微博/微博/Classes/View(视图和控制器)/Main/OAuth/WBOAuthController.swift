//
//  WBOAuthController.swift
//  微博
//
//  Created by Hayder on 2016/11/2.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBOAuthController: UIViewController {

    fileprivate lazy var webView: UIWebView = UIWebView()
    
    override func loadView() {
        
        view = webView
        
        view.backgroundColor = UIColor.white
        
        //设置导航栏
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBackButton: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc private func close(){
        
        dismiss(animated: true, completion: nil)
    }
}
