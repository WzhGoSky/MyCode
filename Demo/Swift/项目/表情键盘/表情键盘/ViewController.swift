//
//  ViewController.swift
//  表情键盘
//
//  Created by Hayder on 2016/11/16.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    lazy var emoticonView: WBEmoticonInputView = WBEmoticonInputView.inputView {[weak self] (em) in
        
        self?.insertEmoticon(em: em)
    }
    
    @IBAction func show(_ sender: Any) {
        
        print(emoticonText)
    }
    
    //返回 textView对应的纯文本的字符串
    var emoticonText: String{
        
        //1.获取textView的属性文本
        guard let attrStr = textView.attributedText else{
            
            return ""
        }
        //2.需要获得属性文本中的图片
        //遍历的范围
        //2.选项
        var result = String()
        
        attrStr.enumerateAttributes(in:  NSRange(location: 0, length: attrStr.length), options: [], using: { (dict, range, _) in
            
            if let attachment = dict["NSAttachment"] {
                
                print("图片")
                
                
            }else
            {
                let subStr = (attrStr.string as NSString).substring(with: range)
                
                result += subStr
                
            }
        })
        
        return attrStr.string
    }
    
    
    //向文本插入表情视图文本
    func insertEmoticon(em: WBEmoticon?) {
        
        guard let em = em else {
            
            //删除文本
            textView.deleteBackward()
            
            return
        }
        
        //2.emoji 字符串
        if let emoji = em.emoji,let textRange = textView.selectedTextRange {
            
            //UITextRange 仅用在此处
            textView.replace(textRange, withText: emoji)
            
            return
        }
        
        //3.图片表情
        //所有的排版系统中，几乎都有一个共同的特点，插入的字符的显示，跟随前一个字符的属性，但是本身没有属性
//        let imageText = NSMutableAttributedString(attributedString: em.imageText(font: textView.font!))
//        //设置图像文字的属性
//        imageText.addAttributes([NSFontAttributeName: textView.font!], range: NSRange(location: 0, length: 1))
        
        let imageText = em.imageText(font: textView.font!)
        
        //获取当前textView的属性文本
        let attrStrM = NSMutableAttributedString(attributedString: textView.attributedText)
        
        //将图像的属性文本插入到当前的光标位置
        attrStrM.replaceCharacters(in: textView.selectedRange, with: imageText)
        
        //重新设置属性文本
        //1.记录光标位置
        let range = textView.selectedRange
        
        //设置文本
        textView.attributedText = attrStrM
        
        //恢复光标位置
        textView.selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.automaticallyAdjustsScrollViewInsets = false
        
        //设置输入视图 -> 属兔刚刚加载，还没有显示，系统默认的键盘还没有生效，可以不刷新输入视图
        textView.inputView = emoticonView
        
        textView.reloadInputViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }

}

