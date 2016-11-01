//
//  WBHomeViewController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

private let cellID = "homeCellID"

class WBHomeViewController: WBBaseViewController {

    fileprivate lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    @objc fileprivate func myFriend(){
    
        let friends = WBDemoViewController()
        
        navigationController?.pushViewController(friends, animated: true);
    
    }
    
    override func loadData(){
        
      
        listViewModel.loadStatus { (isSuccess) in
            
            //结束刷新
            self.refershControl?.endRefreshing()
            self.ispull = false
            
            self.tableView?.reloadData()
        }
    }
}

//设置界面
extension WBHomeViewController{
    
    override func setUpTableView() {
        
        super.setUpTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(myFriend))
    
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension WBHomeViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        cell?.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        return cell!
    }
}
