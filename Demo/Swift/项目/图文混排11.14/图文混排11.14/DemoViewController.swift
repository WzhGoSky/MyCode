//
//  DemoViewController.swift
//  图文混排11.14
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0.图片附件
        let attchment = NSTextAttachment()
        
        attchment.image = #imageLiteral(resourceName: "d_aini")
        
        let height = label.font.lineHeight
        attchment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        //1.属性文本
        let imageStr = NSAttributedString(attachment: attchment)
        
        //2.图文字符串
        let attrStrM = NSMutableAttributedString(string: "我")
        attrStrM.append(imageStr)
        
        
        //3.设置label
        label.attributedText = attrStrM
        
    }
}
