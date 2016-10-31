//
//  WBVistorView.swift
//  微博
//
//  Created by WZH on 16/10/31.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBVistorView: UIView {

    //注册按钮
    lazy var registerButton: UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    //登录按钮
    lazy var loginButton: UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    /// 访客信息字典
    /// imageName / message
    /// 使用字典设置访客视图信息
    ///
    /// - Parameter dict: 信息字典
    ///提示：如果首页 imageName == “”
    var visitorInfo: [String : String]?{
        didSet{
            
            //1>取字典信息
            guard  let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"]else {
                    
                    return
            }
            
            //设置消息
            tipLabel.text = message
            
            //设置图像
            if imageName == "" {
                
                startAnimation()
                
                return
            }
            
            iconView.image = UIImage(named: imageName)
            
            //其他控制器的视图不需要显示小房子
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }
    
    //MARK: 构造函数
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///旋转动画
    private func startAnimation(){
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue =  2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        
        //动画完成不删除，如果iconView被释放，动画会一起销毁！
        //在设置连续动画非常有用
        anim.isRemovedOnCompletion = false
        
        //将动画添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
   
      //MARK: - 私有控件
    //懒加载属性只有调用UIkit控件的制定构造函数，其他都需要使用类型
    //图像视图
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //小房子
    fileprivate lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //遮蔽视图
    fileprivate lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    //提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
    
    
    
}

extension WBVistorView{
    
    fileprivate func setUpUI() -> () {
        
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        //1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //文本居中
        tipLabel.textAlignment = .center
        
        //2.取消autoresizing 
        for v in subviews
        {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        /**
         addConstraint(NSLayoutConstraint(
                                         item: 视图,
                                         attribute: 约束属性, 
                                         relatedBy: 约束关系, 
                                         toItem: 参照视图, 
                                         attribute: 参照属性,
                                         multiplier: 乘积, 
                                         constant: 约束数值))
         
         如果指定狂傲 参照视图为nil  参照属性 .notAnAttribute
         */
        
        //3.自动布局
        //图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        //小房子
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        let margin : CGFloat = 20
        
        //提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))

        //注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))

       //登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0))
        
        //遮罩图像
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .bottom, relatedBy: .equal, toItem: registerButton, attribute: .bottom, multiplier: 1.0, constant: -15))
         addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .top, relatedBy: .equal, toItem: houseIconView, attribute: .bottom, multiplier: 1.0, constant: -35))
    }
    
}
