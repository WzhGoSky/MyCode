//
//  ZHMTRefershView.swift
//  刷新控件
//
//  Created by WZH on 16/11/11.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ZHMTRefershView: UIView {
    
    class func refershView() -> ZHMTRefershView{
        
        let nib = UINib(nibName: "ZHMTRefershView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! ZHMTRefershView
        
    }
    
    @IBOutlet weak var kangarooIconView: UIImageView!
    @IBOutlet weak var buildingIconView: UIImageView!
    @IBOutlet weak var earthIconView: UIImageView!
    
    //
    var parentViewHeight: CGFloat = 0{
        
        didSet{
            
            
            //44 - 126
            if parentViewHeight < 44 {
                
                return;
            }
            
            var scale: CGFloat
            
            if parentViewHeight > 126 {
                
                scale = 1
            } else{
                
                //44-126  0.2 - 1
                //44 == 1
                //126 == 0
                scale = 1 - (126 - parentViewHeight) / (126 - 44)
            }
            
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    override func awakeFromNib() {
        
        //房子
        let build1 = #imageLiteral(resourceName: "icon_building_loading_1")
        let build2 = #imageLiteral(resourceName: "icon_building_loading_2")
        buildingIconView.image = UIImage.animatedImage(with: [build1,build2], duration: 0.5);
        
        //地球
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        ani.toValue = -2*M_PI
        ani.repeatCount = MAXFLOAT
        ani.duration = 3
        ani.isRemovedOnCompletion = false
        
        earthIconView.layer.add(ani, forKey: nil)
        
        //袋鼠
        //1.设置锚点
        let kImage1 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_1")
        let kImage2 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_2")
        kangarooIconView.image = UIImage.animatedImage(with: [kImage1, kImage2], duration: 0.5)
        
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        //2.设置center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 44
        
        kangarooIconView.center = CGPoint(x: x, y: y)
        
        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
    var refershState: ZHRefershState = .Normal{
        
        didSet{
            
            switch refershState {
            case .Normal: break
                
                
            case .Pulling: break
                
            case .Willrefersh: break
             
            }
        }
    }

}
