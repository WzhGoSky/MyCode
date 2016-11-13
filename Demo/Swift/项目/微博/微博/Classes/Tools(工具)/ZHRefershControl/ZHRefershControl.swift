//
//  ZHRefershControl.swift
//  微博
//
//  Created by WZH on 16/11/10.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///刷新临界点
private let ZHRefershOffset: CGFloat = 126

/// 刷新状态
///
/// - Normal: 普通状态
/// - Pulling: 超过零界点如果放手开始刷新
/// - Willrefersh: 用户超过零界点，并且放手
enum ZHRefershState{
    
    case Normal
    case Pulling
    case Willrefersh
}
///刷新控件 - 负责刷新相关的逻辑处理 
class ZHRefershControl: UIControl {

    // MARK - 属性
    fileprivate weak var scrollView: UIScrollView?
    
    fileprivate lazy var refershView: ZHMTRefershView = ZHMTRefershView.refershView()
    
    ///构造函数
    init(){
        super.init(frame: CGRect())
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setUpUI()
    }

//    //本视图从父视图上移除
    override func removeFromSuperview() {
        // superView 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()

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
        //在程序中，通常只监听某一个对象的某几个属性，如果属性太多，方法会很乱
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    
    //所有KVO方法都会调用此方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let sv = scrollView else {
            
            return
        }
        
        //初始化高度应该就是0  contentInset
//        print("top: \(sv.contentInset.top)  y: \(sv.contentOffset.y)")
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        
        if height < 0{
            
            return
        }
        
        //可以根据高度设置刷新控件的frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        refershView.parentViewHeight = height
        
        //判断临界点
        if sv.isDragging{
            
            if  (height > ZHRefershOffset && refershView.refershState == .Normal){
            
                print("放手刷新")
                refershView.refershState = .Pulling
                
            }else if height <= ZHRefershOffset && refershView.refershState == .Pulling{
                
                print("继续使劲")
                refershView.refershState = .Normal
            }
        }else
        {
           //放手刷新 - 判断是否超过临界点
            if refershView.refershState == .Pulling{
                
                print("开始刷新")
               
                beiginRefershing()
                
                //发送时间刷新事件
//                sendActions(for: .valueChanged)
            }
            
        }
    }
    
    ///开始刷新
    func beiginRefershing() {
        
        guard let sv = scrollView else {
            
            return
        }
        
        //判断是否正在刷新如果正在刷新，直接返回
        if refershView.refershState == .Willrefersh {
            
            return
        }
        
        //刷新视图的状态
        refershView.refershState = .Willrefersh
        //修改表格的contenInset
        var inset = sv.contentInset
        inset.top += ZHRefershOffset
        sv.contentInset = inset
        
        refershView.parentViewHeight = ZHRefershOffset
        
        sendActions(for: .valueChanged)
    }
    
    ///结束刷新
    func endRefershing() {
        
        //恢复刷新视图的状态
        guard let sv = scrollView else {
            
            return
        }

        //判断状态，是否在刷新，如果不是，直接返回
        if (refershView.refershState != .Willrefersh)
        {
            return
        }
        refershView.refershState = .Normal
        //恢复表格视图的contentInset
        //修改表格的contenInset
        var inset = sv.contentInset
        inset.top -= ZHRefershOffset
        sv.contentInset = inset
    }

}
extension ZHRefershControl{
    
    fileprivate func setUpUI(){
        
        backgroundColor = superview?.backgroundColor
        
        //设置超出边界不显示
//        clipsToBounds = true
        //添加刷新视图 - 从xib加载出来。默认是xib制定的宽高
        addSubview(refershView)
        
        //自动布局 - 设置xib控件的自动布局需要制定宽高约束
        refershView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refershView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refershView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refershView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refershView.bounds.size.width))
        addConstraint(NSLayoutConstraint(item: refershView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: refershView.bounds.size.height))
    }
}
