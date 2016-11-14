//
//  WBTitleButton.swift
//  微博
//
//  Created by WZH on 16/11/4.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    //重载构造函数
    //如果title 为nil 就显示首页
    init(title: String?) {
        super.init(frame: CGRect())
        
        //1.判断title 是否为nil
        if title == nil {
            
            setTitle("首页", for: .normal)
        }else
        {
            setTitle(title! + " ", for: .normal)
            
            setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        }
        
        //2.设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        
        //3.设置大小
        sizeToFit()
      }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //判断label 和imageview 同时存在
        guard let titleLabel = titleLabel, let imageView = imageView else {
            
            return;
        }
        
        
        //将label 的x 向左移动 imageview的宽度
        //OC中不允许直接修改结构体内部的值，Swift中可以直接修改
//        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        titleLabel.frame.origin.x = 0
        //将imageview的x 向右移label的宽度
//        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
        imageView.frame.origin.x = titleLabel.bounds.width
    }
}
