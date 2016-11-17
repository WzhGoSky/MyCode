//
//  WBComposeTypeButton.swift
//  微博
//
//  Created by Hayder on 2016/11/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
 
    @IBOutlet weak var titleLabel: UILabel!
    
    ///点击按钮要展示控制器的类型
    var claName: String?
    
    class func composeTypeButton(imageName: String, title: String) -> WBComposeTypeButton {
        
        let nib = UINib(nibName: "WBComposeTypeButton", bundle: nil)
        
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        
        return btn

    }
}

