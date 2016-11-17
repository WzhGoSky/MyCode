//
//  WBEmoticonCell.swift
//  表情键盘
//
//  Created by WZH on 16/11/17.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

//表情cell的协议
@objc protocol WBEmoticonCellDelegate: NSObjectProtocol{
    
    //表情cell选中表情/nil 表示删除
    @objc optional func emoticonCellDidSelectedEmoticon(cell:WBEmoticonCell, em: WBEmoticon?)
}
/// 表情的页面cell,每一个页面显示20个表情
/// 每一个cell  就是collectionView 一样大小
/// 每一个表情cell 中用九宫格的算法，自行添加20个表情
///- 最后一个位置放置删除按钮
class WBEmoticonCell: UICollectionViewCell {

    //代理
    weak var delegate: WBEmoticonCellDelegate?
    ///当前页的表情模型数组，最多20个
    var emoticons: [WBEmoticon]?{
    
        //表情包的数量
        didSet{
           
            //隐藏所有按钮
            for v in contentView.subviews{
                v.isHidden = true
                
            }
            
            //显示删除按钮
            contentView.subviews.last?.isHidden = false
            //遍历表情模型数组，设置按钮图像
            for (i,em) in (emoticons ?? []).enumerated(){
                
                //1.取出按钮
                if let btn = contentView.subviews[i] as? UIButton{
                    
                    //如果图像为nil 会清空图像
                    btn.setImage(em.image, for: .normal)
                    
                    //设置emoji的字符串 如果emoji为nil，会清空title 避免复用
                    btn.setTitle(em.emoji, for: .normal)
                    
                    btn.isHidden = false
                }
                
            }
           
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- 监听方法
    //选中表情方法
    @objc fileprivate func selectedEmoticonButton(button: UIButton){
        
        //1.取tag
        let tag = button.tag
        
        //2.根据 tag 判断是否是删除按钮，如果不是删除按钮，取得表情
        var em: WBEmoticon?
        
        if tag < (emoticons?.count)! {
            em = emoticons?[tag]
        }
       
        //3.em为选中的按钮，如果为nil  对应的是删除
        delegate?.emoticonCellDidSelectedEmoticon!(cell: self, em: em)
    }
    
}

fileprivate extension WBEmoticonCell{
    
    //从XIB加载,bounds是XIB中定义的大小，不是size的大小
    //纯代码开发，bounds就是布局属性中设置的itemSize
    func setupUI() {
        
        //连续创建21个按钮
        let rowCount = 3
        let colCount = 7
        
        //左右间距
        let leftMargin: CGFloat = 8
        //底部间距
        let bottomMargin: CGFloat = 16
        
        let w = (bounds.width - 2*leftMargin) / CGFloat(colCount)
        let h = (bounds.height - bottomMargin) / CGFloat(rowCount)
        
        for i in 0..<21{
            let row = i / colCount
            let col = i % colCount
            
            let btn = UIButton()
            let x = leftMargin + CGFloat(col)*w
            let y = CGFloat(row) * h
            
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            contentView.addSubview(btn)
            
            //设置按钮的字体大小
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            
            //设置按钮的tag
            btn.tag = i
            
            //添加监听方法
            btn.addTarget(self, action: #selector(selectedEmoticonButton(button:)), for: .touchUpInside)
        }
        
        //取出末尾删除按钮
        let removeBtn = contentView.subviews.last as! UIButton
        
        //设置图像
        let image = UIImage(named: "compose_emotion_delete", in: WBEmoticonManager.shared.bundle, compatibleWith: nil)
        
        let imageHL = UIImage(named: "compose_emotion_delete_highlighted", in: WBEmoticonManager.shared.bundle, compatibleWith: nil)
        
        removeBtn.setImage(image, for: .normal)
        removeBtn.setImage(imageHL, for: .highlighted)
    }
}
