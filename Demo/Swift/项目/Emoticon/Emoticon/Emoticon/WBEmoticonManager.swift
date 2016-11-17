//
//  WBEmoticonManager.swift
//  Emoticon
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import Foundation
import YYModel
///表情管理器
class WBEmoticonManager {

    //为了便于表情的复用，建立一个单例，之家在一次表情数据
    //表情管理器的单例
    static let shared = WBEmoticonManager()
    
    ///表情包的懒加载数组
    lazy var packages = [WBEmoticonPackage]()
    ///构造函数  如果在init之前增加 private 修饰符，可以要求调用者必须通过 shared访问对象
    ///OC重写 allocWithZone 方法
    private init(){
        
        loadPackages()
    }
}
//MARK： - 表情包数据处理
fileprivate extension WBEmoticonManager{
    
    func loadPackages()  {
        
        //1.读取 emoticons.plist
        guard let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath) as? [[String : String]],
            let models = NSArray.yy_modelArray(with: WBEmoticonPackage.self, json: array) as? [WBEmoticonPackage]
            else{
            
            return
        }
        
        ///设置表情包数据
        //使用 += 不需要再次给package分配空间
        packages += models
        
        print(packages)
        
    }
}
