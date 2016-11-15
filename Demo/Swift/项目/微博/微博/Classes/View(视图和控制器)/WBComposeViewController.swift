//
//  WBComposeViewController.swift
//  微博
//
//  Created by Hayder on 2016/11/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    @objc fileprivate func close(){
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendStatus() {
        
        print("发布微博")
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
        
//        sendButton.isEnabled = false
    }
}
