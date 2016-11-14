//
//  WBEmoticonPackage.swift
//  Emoticon
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit
import YYModel

///表情包模型
class WBEmoticonPackage: NSObject {
    
    ///表情包的分组名
    var groupName: String?
    
    ///表情包目录，从目录下加载 info.plist 可以创建表情模型数组
    var directory: String?{
        
        didSet{
            //当设置目录时，从目录下加载info.plit
            guard let directory = directory,
            let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
            let array = NSArray(contentsOfFile: infoPath) as? [[String : String]],
            let models = NSArray.yy_modelArray(with: WBEmoticon.self, json: array) as? [WBEmoticon]
                else {
                return
            }
            
            //设置表情模型数组
            emoticons += models
        }
    }
    
    ///懒加载的表情模型数组
    ///使用懒加载可以避免后续的解包
    lazy var emoticons = [WBEmoticon]()
    
    override var description: String{
        
        return yy_modelDescription()
    }
}
