//
//  UIImageView+WebImage.swift
//  微博
//
//  Created by Hayder on 2016/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import SDWebImage

extension UIImageView{
    
    //隔离sd_webImage 函数
    ///
    /// - Parameters:
    ///   - urlString: urlString
    ///   - placeholderImage: 占位图
    ///   - isAvatar: 是否是头像
    func wb_setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false)
    {
        //处理url
        guard let urlString = urlString,  let url = URL(string: urlString) else {
            
            //设置站位图片
            image = placeholderImage
            
            return
        }
        
        ///可选项只是用于Swift， OC 中可以nil
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil){ [weak self] (image,_,_,_) in
            
            //完成回调 - 判断是否是头像
            if isAvatar{
                
               self?.image = image?.cz_avatarImage(size: self?.bounds.size)
                
            }
        }
        
    }
}
