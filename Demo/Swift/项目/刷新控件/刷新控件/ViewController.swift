//
//  ViewController.swift
//  刷新控件
//
//  Created by WZH on 16/11/10.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        let refersh: ZHRefershControl = ZHRefershControl()
        
        tableView.addSubview(refersh)
        
    }

}

