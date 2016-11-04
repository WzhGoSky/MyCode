//
//  WBWelcomeView.swift
//  微博
//
//  Created by WZH on 16/11/4.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomeView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    

    class func welcomeView() -> WBWelcomeView{
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        
        //从xib 中加载的是600 x 600
        v.frame = UIScreen.main.bounds
        
        return v
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //initWithcode 只是刚刚从XIB的二进制文件将试图数据加载完成
        //还没有和代码连线，建立起关系，所以开发时，不要在这个方法中处理UI
    }
    
    override func awakeFromNib() {
        
        //设置头像
        guard let urlString = WBNetworkManager.shared.userAccount.avatar_large ,
            let url = URL(string: urlString)
            else {
            
                return
        }
        
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named:"avatar_default_big"))
        
        //设置圆角
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.layer.masksToBounds = true
        
    }
    
    
    
    ///视图被添加到window上，表示视图已经显示
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        //layoutIfNeeded 会直接按照当前的约束直接更新控件位置
        // - 执行之后，控件所在位置就是XIB中布局的位置
        self.layoutIfNeeded()
        //视图是使用
        bottomCons.constant = bounds.size.height - 200
        
        //如果控件们的frame 还没计算好，所有的约束会一起动画
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
            self.layoutIfNeeded()
            
        }, completion: {(_) in
            
            UIView.animate(withDuration: 1.0, animations: { 
                
                self.tipLabel.alpha = 1;
            }, completion: { (_) in
                
                self.removeFromSuperview()
            })
        })
        
    }
    
}
