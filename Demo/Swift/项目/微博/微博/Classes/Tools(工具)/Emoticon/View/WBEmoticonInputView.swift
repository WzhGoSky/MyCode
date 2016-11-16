//
//  WBEmoticonInputView.swift
//  表情键盘
//
//  Created by Hayder on 2016/11/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

//表情输入视图
class WBEmoticonInputView: UIView {

    class func inputView() -> WBEmoticonInputView{
        
        let nib = UINib(nibName: "WBEmoticonInputView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBEmoticonInputView
        
        return v
    }

}
