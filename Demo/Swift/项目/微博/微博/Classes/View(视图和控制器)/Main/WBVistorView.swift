//
//  WBVistorView.swift
//  微博
//
//  Created by WZH on 16/10/31.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBVistorView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WBVistorView{
    
    fileprivate func setUpUI() -> () {
        
        backgroundColor = UIColor.cz_random()
    }
    
}
