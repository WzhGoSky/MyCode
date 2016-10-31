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

    //MARK: - 私有控件
    //懒加载属性只有调用UIkit控件的制定构造函数，其他都需要使用类型
    //图像视图
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //小房子
    fileprivate lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
    //注册按钮
    fileprivate lazy var registerButton: UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    //登录按钮
      fileprivate lazy var loginButton: UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
}

extension WBVistorView{
    
    fileprivate func setUpUI() -> () {
        
        backgroundColor = UIColor.cz_random()
    }
    
}
