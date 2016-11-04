//
//  WBNewFeatureView.swift
//  微博
//
//  Created by WZH on 16/11/4.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit


/// 新特性视图
class WBNewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterbutton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func enterStatus(_ sender: UIButton) {
        
        removeFromSuperview()
    }
    
    
    class func newFeatureView() -> WBNewFeatureView{
        
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBNewFeatureView
        
        //从xib 中加载的是600 x 600
        v.frame = UIScreen.main.bounds
        
        return v
        
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        
        //使用自动布局设置的界面，从XIB加载默认是600 * 600 大小
        //添加4个 图像视图
        
        let count = 4
        let rect = UIScreen.main.bounds
        
        for i in 0..<count{
            
            let imageName = "new_feature_\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            //设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(iv)
        }
        
        
        
        //scrollview属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        //隐藏按钮
        enterbutton.isHidden = true
    }
}

extension WBNewFeatureView: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //滚动到最后一屏，让视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //2.判断是否最后一页
        if page == scrollView.subviews.count{
            
            removeFromSuperview()
        }
        
        //3.如果是倒数第二页，显示按钮
        enterbutton.isHidden = (page != scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //一旦滚动隐藏按钮
        enterbutton.isHidden = true
        
        //计算当前页码
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        pageControl.currentPage = page
        
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
