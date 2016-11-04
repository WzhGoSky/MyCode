//
//  WBOAuthController.swift
//  微博
//
//  Created by Hayder on 2016/11/2.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBOAuthController: UIViewController {

    fileprivate lazy var webView: UIWebView = UIWebView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        
        view = webView
        
        webView.delegate = self
        view.backgroundColor = UIColor.white
        
        //取消滚动视图
        webView.scrollView.isScrollEnabled = false
        //设置导航栏
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", fontSize: 16, target: self, action: #selector(close), isBackButton: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", fontSize: 16, target: self, action: #selector(autoFill), isBackButton: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURI)"
        
        //1.url
        guard  let url = URL(string: urlString)
            else{
            
            return
        }
        //2.建立请求
         let request = URLRequest(url: url)
        
        //3.加载请求
        webView.loadRequest(request)

    }

    ///关闭控制器
    @objc fileprivate func close(){
        
        SVProgressHUD.dismiss()
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func autoFill(){
        
        //准备js
        let js = "document.getElementById('userId').value = '1209686544@qq.com';" + "document.getElementById('passwd').value = '19910807wzh110.';"
        
        
        //让webView执行js
        webView.stringByEvaluatingJavaScript(from: js)
    }
}

extension WBOAuthController: UIWebViewDelegate{
    
    //webView将要加载请求
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        if request.url?.absoluteString.hasPrefix(WBRedirectURI) == false{
            
            return true
        }
        
        //? 后面的所有部分
        if request.url?.query?.hasPrefix("code=") == false {
            
            print("取消授权")
            close()
            
            return false
        }
        
        print("获取授权码")
        //3. 从query字符串中取出授权码
        //代码走到此处， url中一定有查询字符串，并且包含‘code=’
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        
        print("授权码 -- \(code)")
        
        WBNetworkManager.shared.loadAccessToken(code: code, competition:{ (isSuccess) in
            
            if !isSuccess{
                
                SVProgressHUD.showInfo(withStatus: "登陆失败")
            }else
            {
                //成功
                SVProgressHUD.showInfo(withStatus: "登陆成功")
                
                //1.发出通知
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: WBUserLoginSuccessNotification),
                    object: nil)
                
                //2.关闭窗口
                self.close()
            }
        })
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
