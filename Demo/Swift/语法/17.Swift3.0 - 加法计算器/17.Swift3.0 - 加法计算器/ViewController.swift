//
//  ViewController.swift
//  17.Swift3.0 - 加法计算器
//
//  Created by Hayder on 16/10/14.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var result: UILabel?
    var numText1: UITextField?
    var numText2: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    /// 计算结果
    func calc() {
        
        //将文本框内容转换为数值
        //Int? 如果文本框内容不是数字 Int之后是nil
        //先测试：let num1 = Int(numText1?.text ?? "")如果不是数字就会输出为空
        guard let num1 = Int(numText1?.text ?? ""),let num2 = Int(numText2?.text ?? "")
            else {
            
                print("必须输入数字才能进行计算")
                
                return
        }
        
        result?.text = "\(num1 + num2)"
    }
    
    func setUpUI() -> () {
        
        //1.两个 textField
        let tf1 = UITextField(frame:CGRect(x: 20, y: 20, width: 100, height: 30))
        tf1.borderStyle = .roundedRect
        tf1.text = "0"
        
        view.addSubview(tf1)
        
        let tf2 = UITextField(frame:CGRect(x: 140, y: 20, width: 100, height: 30))
        tf2.borderStyle = .roundedRect
        tf2.text = "0"
        
        view.addSubview(tf2)
        
        //记录属性
        numText1 = tf1
        numText2 = tf2
        
        //2. 3个 label
        let label1 = UILabel(frame: CGRect(x: 120, y: 20, width: 20, height: 30))
        label1.text = "+"
        label1.textAlignment = .center
        view.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 240, y: 20, width: 20, height: 30))
        label2.text = "="
        label2.textAlignment = .center
        view.addSubview(label2)
        
        let label3 = UILabel(frame: CGRect(x: 260, y: 20, width: 80, height: 30))
        label3.textAlignment = .center
        label3.text = "0"
        view.addSubview(label3)
        
        self.result = label3
        
        //4.1个button
        let button = UIButton()
        
        button.setTitle("计算", for: UIControlState(rawValue : 0))
        button.setTitleColor(UIColor.black, for: .normal)
        
        button.sizeToFit()
        button.center = view.center
        
        button.addTarget(self, action: #selector(calc) , for: .touchUpInside)
        view.addSubview(button)
    }

}

