//
//  WBComposeTypeView.swift
//  微博
//
//  Created by Hayder on 2016/11/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit
import pop

class WBComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    //关闭按钮约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    
    //返回前一页按钮约束
    @IBOutlet weak var returnButtonCenterXCons: NSLayoutConstraint!
    
    //返回前一页按钮
    @IBOutlet weak var returnButton: UIButton!
    
    fileprivate var completionBlock:((_ clsName: String?)->())?
    
    
    class func composeTypeView() -> WBComposeTypeView{
        
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView
        
        //xib加载 默认 600 * 600
        v.frame = UIScreen.main.bounds
        
        //设置UI
        v.setUpUI()
        
        return v
        
    }
    ///显示当前视图
    //OC中的block 如果当前方法，不能执行，通常使用属性记录，需要时执行
    func show(compeltion: @escaping (_ clsName: String?)->()) {
        
        //记录闭包
        completionBlock =  compeltion
        
        //1.将当前视图添加到根试图控制器的view上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else{
            
            return
        }
        
        //2.添加视图
        self.alpha = 0
        
        vc.view.addSubview(self)
        
        //3.开始动画
        showCurrentView()
        
        //显示按钮
        showButtons()
    }
    
    
    @objc fileprivate func clickButton(selectedButton: WBComposeTypeButton){
        
        //1.判断当前显示的视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        //遍历当前视图
        for (i,btn) in v.subviews.enumerated(){
            
            //1.缩放动画
            let scaleAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            //x,y 在系统中CGPoint 表示，如果要转换成id 需要使用'NSValue' 包装
            let scale = (selectedButton == btn) ? 2: 0.4
            
            scaleAnim?.toValue = NSValue(cgPoint:CGPoint(x: scale, y: scale))
            
            scaleAnim?.duration = 0.5
            
            btn.pop_add(scaleAnim, forKey: nil)
            
            
            //2.渐变动画 - 动画组
            let alphaAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            alphaAnim.toValue = 0.2
            alphaAnim.duration = 0.5
            
            btn.pop_add(alphaAnim, forKey: nil)
            
            if i==0 {
                
                alphaAnim.completionBlock = { _, _ in
                    
                    self.completionBlock?(selectedButton.claName)
                
                }
            }
        }
        
    }
    
    //点击了更多按钮
    @objc fileprivate func clickMore(){

        //scrollView滚动到第二页
        let point = CGPoint(x: scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(point, animated: true)
        
        
        //让两个按钮分开
        returnButton.isHidden = false
        
        let margin = scrollView.bounds.width / 6
        
        closeButtonCenterXCons.constant += margin
        returnButtonCenterXCons.constant -= margin
        
        UIView.animate(withDuration: 0.25){
            
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func clickReturn(_ sender: UIButton) {
        
        //将滚动视图滚动到第一页
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        
        let margin = scrollView.bounds.width / 6
        //让两个按钮合并
        closeButtonCenterXCons.constant -= margin
        returnButtonCenterXCons.constant += margin
        
        UIView.animate(withDuration: 0.25,animations:{
            
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
        }){ _ in
            
            self.returnButton.isHidden = true
            self.returnButton.alpha = 1
        }
    }
    
    //关闭按钮
    @IBAction func hidden(_ sender: Any) {
        
        hideButton()
    }
    
    /// 按钮数据数组
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]

    
}


//MARK - 动画扩展
fileprivate extension WBComposeTypeView{
    
    // MARK:- 消除动画
    ///隐藏按钮动画
    fileprivate func hideButton(){
        
        //1.根据contentOffset 判断当前显示的子视图
        let page: Int = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v: UIView = scrollView.subviews[page]
        
        //2.遍历 v中所有按钮
        for (i,btn) in v.subviews.enumerated().reversed(){
            
            //创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            //2.设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            
            
            //设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            btn.pop_add(anim, forKey: nil)
            
            //第0个按钮的动画最后一个执行
            if i == 0{
                
                anim.completionBlock = { _, _ in
                    
                    self.hideCurretnView()
                }
            }
        }
        
    }
    
    fileprivate func hideCurretnView(){
        
        //1.创建动画
        let anim:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        //添加视图
        pop_add(anim, forKey: nil)
        
        //添加完成的监听添加监听方法
        anim.completionBlock = { _,_ in
            
            self.removeFromSuperview()
        }
    }
    
    //MARK - 显示部分的动画
    fileprivate func showCurrentView(){
        
        //创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.5
        
        //2.添加视图
        pop_add(anim, forKey: nil)
    }
    
    //弹力显示所有按钮
    fileprivate func showButtons(){
    
        //1.获取scrollview的子视图的第0个视图
        let v = scrollView.subviews[0]
        
        //2.遍历 v中的所有按钮
        for (i,btn) in v.subviews.enumerated(){
            
            //创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            //2.设置动画属性
            anim.fromValue = btn.center.y + 350
            anim.toValue = btn.center.y
            
            //弹力系数
            anim.springBounciness = 8
            anim.springSpeed = 10
            
            //设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            btn.pop_add(anim, forKey: nil)
        }
        
    }
    
}

extension WBComposeTypeView {
    
    fileprivate func setUpUI(){
        
        //强行更新布局
        layoutIfNeeded()
        
        //向scorllview添加视图
        let rect = scrollView.bounds;
        
        let width = scrollView.bounds.width
        
        for i in 0..<2{
            
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i)*width, dy: 0))
            
            addButtons(v: v, idx: i * 6)
            
            scrollView.addSubview(v)
        }
        
        //设置scrollview
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isScrollEnabled = false
    }
    
    //添加按钮
    private func addButtons(v: UIView, idx: Int){
        
        let count = 6
        //从idx开始，添加6个按钮
        for i in idx..<(idx + count)
        {
            
            if  i >= buttonsInfo.count{
                
                break
            }
            
            //0> 从数组字典中获取图像名称和title
            let dict = buttonsInfo[i]
           
            //从数组字典中获取图像名称和title
            guard let imageName = dict["imageName"],let title = dict["title"] else{
                
                continue
            }
            
            let btn = WBComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            v.addSubview(btn)
            
            //添加监听方法
            if let actionName = dict["actionName"]{
                
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }else {
                
                //FIXME 展示的控制器
                btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            }
            
            //设置要展现的类名 - 不需要任何判断
            btn.claName = dict["clsName"]

        }
        
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3*btnSize.width)/4
        
        for (i, btn) in v.subviews.enumerated(){
            
            let col = i % 3
            let x = CGFloat(col+1) * margin + CGFloat(col)*btnSize.width;
            
            let y: CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}
