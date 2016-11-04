//
//  WBWelcomeView.swift
//  微博
//
//  Created by WZH on 16/11/4.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBWelcomeView: UIView {


    class func welcomeView() -> WBWelcomeView{
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        
        //从xib 中加载的是600 x 600
        v.frame = UIScreen.main.bounds
        
        return v
        
    }
    
    
    
}
