//
//  WBStatusViewModel.swift
//  微博
//
//  Created by WZH on 16/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import Foundation
import YYModel

///单条微博
/**
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要
 1.遵守CustomStringConvertible
 2.实现description 计算型属性
 
 关于表格的性能优化
 
 - 尽量少计算，所有需要的素材提前计算好
 - 控件上不要设置圆角半径，所有图像渲染属性，都要注意
 - 不要动态创建控件，所有需要的控件，都要提前创建好，在显示的时候根据数据隐藏/显示、
 - cell的控件的层次越少越好，数量越少越好
 */

class WBStatusViewModel: CustomStringConvertible {
    
    var status: WBStatus
    
    //存储型属性(用内存换CPU)
    var memberIcon: UIImage?
    
    var vipIcon: UIImage?
    
    //转发文字
    var retweetedStr: String?
    //评论文字
    var commentStr: String?
    //点赞文字
    var likeStr: String?
    
    var pictureViewSize = CGSize()
    
    /// 构造函数
    init(model: WBStatus) {
        
        self.status = model
        
        //common_icon_membership_level1
        //会员等级
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)!<7{
            
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            
            memberIcon = UIImage(named: imageName)
            
        }
        
        switch model.user?.verified_type ?? -1{
        case 0:
            
            vipIcon = UIImage(named:"avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named:"avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named:"avatar_grassroot")
        default:
            break
        }
        
        retweetedStr = countString(count: model.reposts_count, defaultString: "转发")
        commentStr = countString(count: model.comments_count, defaultString: "评论")
        likeStr = countString(count: model.attitudes_count, defaultString: "赞")
        
        //计算配图模型大小
        pictureViewSize = calcPictureViewSize(count: status.pic_urls?.count)
    }
    
    
    /// 配图视图的大小
    ///
    /// - Parameter count: 配图视图张数
    /// - Returns: 配图视图的大小
    private func calcPictureViewSize(count: Int?) -> CGSize{
        
        if count == 0 || count == nil{
            
            return CGSize()
        }
        
        //2.计算高度
        let row = (count! - 1)/3 + 1
        
        let height = WBStatusPictureViewOutterMargin + CGFloat(row) * WBStatusPictureItemWith + CGFloat(row-1) * WBStatusPictureViewInnerMargin
        
        return CGSize(width: WBStatusPictureItemWith, height: height)
    }
    
    
    var description: String{
        
        return status.description
    }
    
    
    /// 给定一个数字，返回对应的描述结果
    ///
    /// - Parameters:
    ///   - count: 数字
    ///   - defaultString: 默认字符串
    /// - Returns: 返回对应的字符串
    /**
        == 0 显示默认标题
        超过10000 显示 x.xx万
        如果数量 < 10000，显示实际数字
     */
    private func countString(count: Int, defaultString: String) -> String{
        
        if count == 0 {
            
            return defaultString
        }
        
        if count < 10000 {
            
            return count.description
        }
        
        return String(format: "%.02f万", Double(count) / 10000)
    
    }
}
