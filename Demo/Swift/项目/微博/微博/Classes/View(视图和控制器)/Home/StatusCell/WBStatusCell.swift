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
            
            pictureView.heightcons.constant = viewModel?.pictureViewSize.height ?? 0
            
            pictureView.urls = viewModel?.status.pic_urls
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
