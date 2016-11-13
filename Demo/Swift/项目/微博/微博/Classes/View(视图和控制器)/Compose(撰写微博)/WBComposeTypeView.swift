//
//  WBComposeTypeView.swift
//  微博
//
//  Created by Hayder on 2016/11/13.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
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
    func show() {
        
        //1.将当前视图添加到根试图控制器的view上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else{
            
            return
        }
        
        //2.添加视图
        vc.view.addSubview(self)
        
    }
    
    @IBAction func hidden(_ sender: Any) {
        
        removeFromSuperview()
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


extension WBComposeTypeView {
    
    fileprivate func setUpUI(){
        
        //强行更新布局
        layoutIfNeeded()
        
        //向scorllview添加视图
        let rect = scrollView.bounds;
        
        let v = UIView(frame: rect)
        
        addButtons(v: v, idx: 0)
        
        
        scrollView.addSubview(v)
    }
    
    //添加按钮
    private func addButtons(v: UIView, idx: Int){
        
        let count = 6
        //从idx开始，添加6个按钮
        for i in idx..<(idx + count)
        {
            //0> 从数组字典中获取图像名称和title
            let dict = buttonsInfo[i]
            
            if  idx >= buttonsInfo.count{
                
                break
            }
            
            //从数组字典中获取图像名称和title
            guard let imageName = dict["imageName"],let title = dict["title"] else{
                
                continue
            }
            
            let btn = WBComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            v.addSubview(btn)
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
