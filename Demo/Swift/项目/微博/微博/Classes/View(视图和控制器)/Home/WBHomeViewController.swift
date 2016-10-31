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

    var datalist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpUI()
        
        loadData()
    }
    
    @objc fileprivate func myFriend(){
    
        let friends = WBDemoViewController()
        
        navigationController?.pushViewController(friends, animated: true);
    
    }
    
    override func loadData(){
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime){
            
            for i in 0..<20
            {
                self.datalist.insert(i.description, at: 0)
            }
            
            //结束刷新
            self.refershControl?.endRefreshing()
            
            self.tableView?.reloadData()
        }

    }
}

extension WBHomeViewController{
    
    override func setUpUI(){
        
        super.setUpUI()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(myFriend))
    
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension WBHomeViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datalist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        cell?.textLabel?.text = datalist[indexPath.row]
        
        return cell!
    }
}
