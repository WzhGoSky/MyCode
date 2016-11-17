//
//  WBStatusPictureView.swift
//  微博
//
//  Created by Hayder on 2016/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

    @IBOutlet weak var heightcons: NSLayoutConstraint!
    
    var viewModel: WBStatusViewModel?{
    
        didSet{
            
            calcViewSize()
            
            ///设置配图 
            urls = viewModel?.picUrls
        }
    }
    
    /// 根据视图模型的配图大小，调整显示内容
    private func calcViewSize(){
        
        //处理宽度
        //1>单图，根据配图视图大小，修改，subview[0] 的宽高
        if viewModel?.picUrls?.count == 1{
            
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            let v = subviews[0]
            v.frame = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: viewSize.width, height: viewSize.height - WBStatusPictureViewOutterMargin)
        }else{
             //2>多图，恢复第0个视图的宽高 或者无图
            
            let v = subviews[0]
            v.frame = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWith, height: WBStatusPictureItemWith)
        }
//        //修改高度约束
        heightcons.constant = viewModel?.pictureViewSize.height ?? 0
        
    }
    
   private var urls: [WBStatusPicture]?{
    
        didSet{
            //1.隐藏所有imageviews
            for v in subviews{
                
                v.isHidden = true
            }
            
            //2.遍历urls数组，顺序设置图像
            var index = 0
            for url in urls ?? []{
                
                let iv = subviews[index] as! UIImageView
                
                if index == 1 && urls?.count == 4{
                    
                    index += 1
                }
                
                //设置图像
                iv.wb_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                
                //显示图像
                iv.isHidden = false
                
                index += 1
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        
        setUpUI()
    }
}

extension WBStatusPictureView {
    
    fileprivate func setUpUI(){
        
        //设置背景颜色
        backgroundColor = superview?.backgroundColor
        
        //超出边界的内容不显示
        clipsToBounds = true
        
        let count = 3
        
        let rect = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWith, height: WBStatusPictureItemWith)
        
        //1.循环创建9个imageview
        for i in 0..<count * count
        {
            let iv = UIImageView()
            //行
            let row = CGFloat(i / count)
            let colums = CGFloat(i % count)
            
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            let x = colums * (WBStatusPictureItemWith + WBStatusPictureViewInnerMargin)
            let y = row * (WBStatusPictureItemWith + WBStatusPictureViewInnerMargin)
            
            iv.frame = rect.offsetBy(dx: x, dy: y)
            
            self.addSubview(iv)
            
        }
        
    }
}
