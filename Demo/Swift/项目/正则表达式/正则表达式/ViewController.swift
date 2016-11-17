//
//  ViewController.swift
//  正则表达式
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1."<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>"
        //目标取出href中的连接，以及文本描述
        let string = "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>"
        
        let result = string.zh_href()
        
        print(result?.text ?? " ")
        print(result?.link ?? " ")
    }
    
    func demo() {
        
        //目标取出href中的连接，以及文本描述
        let string = "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>"
        
        //2.创建正则表达式
        //0.pattern : 匹配方案(常说的正则表达式，就是pattern的写法（匹配方案）)
        //0: 和匹配方案完全一致的字符串
        //1.第一个 () 中的内容
        //2.第二个 () 中的内容
        // ... 索引从左向右顺序递增
        //对于模糊匹配，如果关心的内容，就是用(.*?),然后通过索引获取结果
        //如果不关心的内容，就是‘.*？’,可以匹配任意内容
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        //        let pattern = "</.*?>(.*?)</a>"
        //1.创建正则表达式，如果pattern失败，抛出异常
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            
            return
        }
        
        //2.进行查找方法
        //只找一个匹配项 / 查找多个匹配项
        guard let result = regx.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.characters.count)) else{
            
            print("没有找到匹配项")
            return
        }
        
        //result中只有两个重要的方法
        //result.numberOfRanges -> 查找到的范围数量
        //result.range(at: idx) -> 指定‘索引’位置的范围
        print(result)
        
        for idx in 0..<result.numberOfRanges{
            
            let r = result.rangeAt(idx)
            let subStr = (string as NSString).substring(with: r)
            
            print(subStr)
        }
    }

}

