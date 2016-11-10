//
//  ZHRefershControl.swift
//  微博
//
//  Created by WZH on 16/11/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ZHRefershControl: UIControl {

    // MARK - 属性
    fileprivate weak var scrollView: UIScrollView?
    
    ///构造函数
    init(){
        super.init(frame: CGRect())
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setUpUI()
    }

    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        /**
            newSuperView 就是父视图
         */
        super.willMove(toSuperview: newSuperview)
        
        //记录父视图
        guard let sv = newSuperview as? UIScrollView else {
            
            return
        }
        
        //记录父视图
        scrollView = sv
        
        //KVO 监听父视图的contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    
    //所有KVO方法都会调用此方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        print(scrollView?.contentOffset ?? CGPoint())
        
        guard let sv = scrollView else {
            
            return
        }
        
        //初始化高度应该就是0  contentInset
        print("top: \(sv.contentInset.top)")
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        //可以根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
    }
    
    ///开始刷新
    func beiginRefershing() {
        
        
    }
    
    ///结束刷新
    func endRefershing() {
        
    }

}
extension ZHRefershControl{
    
    fileprivate func setUpUI(){
        
        backgroundColor = UIColor.yellow
    }
}
