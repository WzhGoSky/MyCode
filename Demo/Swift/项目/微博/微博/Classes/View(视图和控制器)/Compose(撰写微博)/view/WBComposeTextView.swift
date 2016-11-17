//
//  WBComposeTextView.swift
//  微博
//
//  Created by WZH on 16/11/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///撰写微博的文本视图
class WBComposeTextView: UITextView {

    ///占位标签
    fileprivate lazy var placeholderLabel = UILabel()
    
    override func awakeFromNib() {
        
        setupUI()
    }
    
    @objc func textChanged(n: Notification){
        
        //如果有文本，不现实占位标签，否则显示
        placeholderLabel.isHidden = self.hasText
    }
    
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }

}

fileprivate extension WBComposeTextView{
    
    func setupUI() {
        
        //0.注册通知- 通知一对多，如果其他控件监听当前视图的文本，不会影响
        //但是如果使用代理，其他控件就无法使用代理监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        
        //1.设置占位标签
        placeholderLabel.text = "分享新鲜事.."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)
    }
}
