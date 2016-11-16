//
//  WBComposeViewController.swift
//  微博
//
//  Created by Hayder on 2016/11/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import SVProgressHUD

///撰写微博控制器
/**
    加载视图控制器的时候，如果XIB和控制器同名，默认的构造函数会优先加载XIB
 */
class WBComposeViewController: UIViewController {

    ///发布按钮
    @IBOutlet var sendButton: UIButton!
    
    ///标题标签 换行热键 - option + 回车
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    ///工具栏底部约束
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        //监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardChanged), name:NSNotification.Name.UIKeyboardWillChangeFrame , object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        textView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    @objc func keyBoardChanged(n: Notification){
        
        //1. 目标rect
       guard let rect = (n.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,let duration = (n.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else{
            
            return
        }
        
        //2. 设置底部约束的高度
        let offset = view.bounds.height - rect.origin.y
        
        //3.更新底部约束
        toolBarBottomCons.constant = offset
        
        //4.动画更新
        UIView.animate(withDuration: duration){
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func close(){
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendStatus() {
        
        //1.获取微博文字
        guard let text = textView.text else{
            
            return
        }
        
        //FIXME - 临时测试带图片微博
        let image = UIImage(named: "")
        //2.发布微博
        WBNetworkManager.shared.postStatus(text: text,image: image ){ (result, isSuccess) in
            
            //修改样式
            SVProgressHUD.setDefaultStyle(.dark)
            
            let message = isSuccess ? "发布成功":"网络不给力"
            
            SVProgressHUD.showInfo(withStatus: message)
            
            //如果成功，延迟一段时间关闭窗口
            if isSuccess{
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                    
                    //恢复样式
                    SVProgressHUD.setDefaultStyle(.light)
                    
                    self.close()
                })
            }
        }
    }
    
}

fileprivate extension WBComposeViewController{
    
    func setUpUI() {
        
        view.backgroundColor = UIColor.white
        
        setUpNavigation()
        
        setupToolbar()
    }
    
    ///设置工具栏
    func setupToolbar() {
        
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]
        
        //遍历数组
        var items = [UIBarButtonItem]()
        
        for s in itemSettings{
            
            guard let imageName = s["imageName"] else{
                
                continue
            }
            let image = UIImage(named: imageName)
            let imageHL = UIImage(named: imageName + "_highlighted")
            
            let btn = UIButton()
            btn.setImage(image, for: .normal)
            btn.setImage(imageHL, for: .highlighted)
            
            //追加按钮
            items.append(UIBarButtonItem(customView: btn))
            
            btn.sizeToFit()
            
            //追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        
        //删除末尾弹簧
        items.removeLast()
        
        toolBar.items = items
    }
    ///设置导航栏
    func setUpNavigation() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"退出",target: self,action: #selector(close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        navigationItem.titleView = titleLabel
        
    }
}

extension WBComposeViewController: UITextViewDelegate{
    
    ///文本视图文字变化
    func textViewDidChange(_ textView: UITextView) {
        
        sendButton.isEnabled = textView.hasText
    }
}
