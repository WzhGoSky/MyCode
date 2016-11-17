//
//  WBEmoticonManager.swift
//  Emoticon
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit
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
    
    ///表情bundle懒加载属性
    lazy var bundle: Bundle = {
    
        let path = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil)
        return Bundle(path: path!)!
    }()
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
        
    }
}

// MARK: - 符号表情处理
extension WBEmoticonManager{
    
    /// 将给定的字符串转换成属性文本
    /// 关键点: 要按照匹配结果倒序替换文本！
    /// - Parameter string: 完整的字符串
    /// - Returns: 属性文本
    func emoticonString(string: String, font: UIFont) -> NSAttributedString {
        
        let attrString = NSMutableAttributedString(string: string)
        
        //建立正则表达式，过滤所有的表情文字
        //[]() 都是正则表达式的关键字，如果要参与匹配，需要转义
        let patter = "\\[.*?\\]"
        guard let regx = try? NSRegularExpression(pattern: patter, options: []) else{
            
            return attrString
        }
        
        //匹配所有项
        let matches = regx.matches(in: string, options: [], range: NSRange(location: 0, length: attrString.length))
        
        //遍历所有匹配结果
        for m in matches.reversed() {
            
            let r = m.rangeAt(0)
            let subStr = (attrString.string as NSString).substring(with: r)
            
            print(subStr)
            //使用subStr查找对应的表情符号
            if let em = WBEmoticonManager.shared.findEmoticon(string: subStr){
                
                //使用表情符号替换
                attrString.replaceCharacters(in: r, with: em.imageText(font: font))
            }
            
            
        }
        
        //统一设置一遍字符串的属性 除了设置字体，还需要设置颜色
        attrString.addAttributes([NSFontAttributeName: font,NSForegroundColorAttributeName: UIColor.darkGray], range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }

    /// 根据String在所有的表情符号中查找对应的表情模型对象
    /// - 如果找到返回表情模型，否则返回nil
    func findEmoticon(string: String) -> WBEmoticon? {
        
        //遍历表情包
        //OC中过滤使用[谓词]
        for p in packages{
            
            //2.表情数组中过滤string
//            //方法1
//            let result = p.emoticons.filter({ (em) -> Bool in
//                
//                return em.chs == string
//            })
//            //方法2 尾随闭包
//            let result = p.emoticons.filter(){ (em) -> Bool in
//                
//                return em.chs == string
//            }
            //方法3 - 如果闭包中只有一句，并且是返回，
            //1.闭包格式可以省略
            //2.参数省略以后，使用$0, $1一次代替原来参数
            //3.return也可以省略
            let result = p.emoticons.filter(){
                
                $0.chs == string
            }
            //3.判断结果数组的数量
            if result.count == 1 {
                
                return result[0]
            }
        }
        
        return nil
    }
}
