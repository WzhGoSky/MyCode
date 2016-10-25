//
//  DetailController.swift
//  25.Swift3.0 - 私人通讯录
//
//  Created by Hayder on 16/10/18.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class DetailController: UITableViewController {

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var titleText: UITextField!
    
    var person: Person?
    
    //闭包的返回值是可选的
//    var completionCallBack: () -> ()?
    //闭包是可选的
    var completionCallBack: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //判断person是否有值，如果有设置UI
        
        if let person = person {
            
            nameText.text = person.name
            phoneText.text = person.phone
            titleText.text = person.title
        }
        
    }

    @IBAction func savePerson(_ sender: AnyObject) {
        
        //判断person是否为nil
        if person == nil {
            
            person = Person()
        }
        
        
        person?.name = nameText.text
        person?.phone = phoneText.text
        person?.title = titleText.text
        
        //执行闭包回调
        //！强行解包 -> 闭包一定不要用！
        //？可选解包 ->如果闭包为nil,就什么也不做
        completionCallBack?()
        
        //Expression of type 'UIViewController?' is unused  方法返回值没有使用
        //_ 可以忽略一切不关心的内容！
        _ = navigationController?.popViewController(animated: true)
    }
}
