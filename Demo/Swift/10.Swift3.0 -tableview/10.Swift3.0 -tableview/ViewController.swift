//
//  ViewController.swift
//  10.Swift3.0 -tableview
//
//  Created by Hayder on 16/9/26.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        //提示： textLabel 是可选的
        //如果 textLabel 有，就使用，如果没有，就什么也不做
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
        
    }
    
    func setUp() {
        
        //1.创建表格
        let tv = UITableView(frame: view.bounds, style: .plain)
        
        //2.添加到视图
        view.addSubview(tv)
        
        //3.注册可重用项
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        //4.设置数据源
        tv.dataSource = self;
    }
}

