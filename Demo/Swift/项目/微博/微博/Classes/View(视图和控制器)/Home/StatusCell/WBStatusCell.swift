//
//  WBStatusCell.swift
//  微博
//
//  Created by WZH on 16/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    
    var viewModel: WBStatusViewModel?{
        didSet{
            
            let status = viewModel?.status
            let user = status?.user
            
            //微博文本
            statusLabel.text = status?.text
            //姓名
            nameLabel.text = user?.screen_name
            
            //设置会员图标 - 直接获取属性，不需要计算
            memberIconView.image = viewModel?.memberIcon
            //认证图标
            vipIcon.image = viewModel?.vipIcon
            
            //设置头像
            iconView.wb_setImage(urlString: user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"),isAvatar: true)
            
            toolBar.viewModel = viewModel
            
            pictureView?.viewModel = viewModel
            
            //设置转发微博的文字
            retweetedLabel?.text = viewModel?.retweetedText
            
            print("source: \(viewModel?.status.source)")
            
            //设置来源
            sourceLabel.text = viewModel?.sourceStr
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var memberIconView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var vipIcon: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    ///底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    
    ///配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    
    //原创微博没有此控件  一定要用？表示可选
    @IBOutlet weak var retweetedLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //离屛渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        //栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        //cell 优化，要尽量减少图层的数量，相当于就只有一层！
        //停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        //使用“栅格化” 必须注意指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}
