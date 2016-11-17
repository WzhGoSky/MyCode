//
//  WBEmoticonInputView.swift
//  表情键盘
//
//  Created by Hayder on 2016/11/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///可重用标识符
private let cellID = "cellID"

//表情输入视图
class WBEmoticonInputView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolbar: UIView!
<<<<<<< HEAD
    
    //选中表情回调闭包属性
    fileprivate var selectedEmoticonCallBack: ((_ em: WBEmoticon?) ->())?
    class func inputView(selectedEmoticon: @escaping (_ em: WBEmoticon?)->()) -> WBEmoticonInputView{
=======
    class func inputView() -> WBEmoticonInputView{
>>>>>>> origin/master
        
        let nib = UINib(nibName: "WBEmoticonInputView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBEmoticonInputView
        
        //记录闭包
        v.selectedEmoticonCallBack = selectedEmoticon
        return v
    }

    override func awakeFromNib() {
        
        collectionView.register(WBEmoticonCell.self, forCellWithReuseIdentifier: cellID)
    }
}

extension WBEmoticonInputView: UICollectionViewDataSource{
    
    //返回表情包的数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return WBEmoticonManager.shared.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return WBEmoticonManager.shared.packages[section].numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WBEmoticonCell
        //设置cell
        let package: WBEmoticonPackage = WBEmoticonManager.shared.packages[indexPath.section]
        cell.emoticons = package.emoticon(page: indexPath.item)
        
        //cell 设置不适合用闭包
        cell.delegate = self
        
        return cell
    }
}

//设置代理
extension WBEmoticonInputView: WBEmoticonCellDelegate{
    
    func emoticonCellDidSelectedEmoticon(cell: WBEmoticonCell, em: WBEmoticon?) {
        
        //执行闭包回调选中的表情
        selectedEmoticonCallBack?(em)
    }
}
