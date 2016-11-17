//
//  WBEmoticonToolbar.swift
//  表情键盘
//
//  Created by WZH on 16/11/17.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///表情键盘底部工具栏
class WBEmoticonToolbar: UIView {

    override func awakeFromNib() {
        
        setupUI()
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        //布局按钮的数量
        let count = subviews.count
        let w = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: w, height: bounds.height)
    
        for (i,btn) in subviews.enumerated(){
            
            btn.frame = rect.offsetBy(dx: CGFloat(i) * w, dy: 0)
        }
    }
}

fileprivate extension WBEmoticonToolbar{
    
    func setupUI() {
        
        //获取表情管理器单例
        let manager = WBEmoticonManager.shared
        
        //设置按钮
        for p in manager.packages{
            
            let btn = UIButton()
            
            btn.setTitle(p.groupName, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            
<<<<<<< HEAD
            //设置按钮图片
            let imageName = "compose_emotion_table_\(p.bgImageName ?? "")_normal"
            let imageNameSL = "compose_emotion_table_\(p.bgImageName ?? "")_selected"
            
            var image = UIImage(named: imageName, in: manager.bundle, compatibleWith: nil)
            var imageSL = UIImage(named: imageNameSL, in: manager.bundle, compatibleWith: nil)

            //图像拉伸
            let size = image?.size ?? CGSize()
            let inset = UIEdgeInsets(top: size.height * 0.5,
                                     left: size.width * 0.5,
                                     bottom: size.height * 0.5,
                                     right: size.width * 0.5)
            
            
            image = image?.resizableImage(withCapInsets: inset)
            imageSL = imageSL?.resizableImage(withCapInsets: inset)
            
            btn.setBackgroundImage(image, for: .normal)
            btn.setBackgroundImage(imageSL, for: .highlighted)
            btn.setBackgroundImage(imageSL, for: .selected)
            
=======
>>>>>>> origin/master
            addSubview(btn)
        }
    }
}
