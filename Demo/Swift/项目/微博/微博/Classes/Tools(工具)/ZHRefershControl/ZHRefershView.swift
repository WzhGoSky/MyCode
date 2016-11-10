//
//  ZHRefershView.swift
//  刷新控件
//
//  Created by Hayder on 2016/11/10.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ZHRefershView: UIView {

    //刷新状态
    /**
     UIView 封装的旋转动画
     - 默认顺时针旋转
     - 就近原则 
     - 要想实现同方向旋转，需要调整一个 非常小的数字(近)
     - 如果想实现360旋转，需要核心动画 CAAnimation
     */
    var refershState: ZHRefershState = .Normal{
        
        didSet{
            
            switch refershState {
            case .Normal:
                tipLabel.text = "继续使劲拉"
                
                UIView.animate(withDuration: 0.25, animations: {
                    
                    self.tipIcon.transform = CGAffineTransform.identity
                })
                
            case .Pulling:
                tipLabel.text = "放手就刷新"
                
                UIView.animate(withDuration: 0.25, animations: { 
                    
                    self.tipIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.001))
                })
                
            case .Willrefersh:
                tipLabel.text = "正在刷新中..."
                
                //隐藏提示图标
                tipIcon.isHidden = true
                
                //显示据恶化
                indicator.startAnimating()
            }
        }
    }
    
   ///指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    ///提示图标
    @IBOutlet weak var tipIcon: UIImageView!
    ///提示标签
    @IBOutlet weak var tipLabel: UILabel!
    
    class func refershView() -> ZHRefershView{
        
        let nib = UINib(nibName: "ZHRefershView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! ZHRefershView
        
    }
}
