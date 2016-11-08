//
//  WBStatusToolBar.swift
//  微博
//
//  Created by Hayder on 2016/11/7.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {

    var viewModel: WBStatusViewModel?{
        
        didSet{
            
            retweetedButton.setTitle("\(viewModel?.retweetedStr ?? "")", for: .normal)
            commentdButton.setTitle("\(viewModel?.commentStr ?? "")", for: .normal)
            likeButton.setTitle("\(viewModel?.likeStr ?? "")", for: .normal)
        }
    }
    
    ///转发
    @IBOutlet weak var retweetedButton: UIButton!
    
    ///评论
    @IBOutlet weak var commentdButton: UIButton!
    
    ///赞
    @IBOutlet weak var likeButton: UIButton!
    

}
