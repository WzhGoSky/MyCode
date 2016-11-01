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
        
        loadData()
    }
    
    @objc fileprivate func myFriend(){
    
        let friends = WBDemoViewController()
        
        navigationController?.pushViewController(friends, animated: true);
    
    }
    
    override func loadData(){
        
        //用网络工具加载微博数据
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token" : "2.00c54PZG8Tsb9Cedbb0b6f96qvNt5E"]
        
        WBNetworkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
            
            print(json ?? "0")
        }
            , failure: { (_ , error) in
                
            print(error)
        })
        
        
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime){
            
           
            for i in 0..<15
            {
                if(self.ispull)
                {
                    self.datalist.append("上拉"+(i.description))
                    
                }else
                {
                   self.datalist.insert(i.description, at: 0)
                }
               
            }
            
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
        
        return datalist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        cell?.textLabel?.text = datalist[indexPath.row]
        
        return cell!
    }
}
