//
//  ViewController.swift
//  表情键盘
//
//  Created by Hayder on 2016/11/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    lazy var emoticonView: WBEmoticonInputView = WBEmoticonInputView.inputView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.automaticallyAdjustsScrollViewInsets = false
        
        //设置输入视图 -> 属兔刚刚加载，还没有显示，系统默认的键盘还没有生效，可以不刷新输入视图
        textView.inputView = emoticonView
        
        textView.reloadInputViews()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }

}

