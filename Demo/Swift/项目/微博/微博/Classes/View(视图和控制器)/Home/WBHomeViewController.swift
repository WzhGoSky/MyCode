//
//  WBHomeViewController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

///原创微博可重用cellID
private let originalCellId = "originalCellId"
private let retweetedCellId = "retweetedCellId"

class WBHomeViewController: WBBaseViewController {

    fileprivate lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc fileprivate func myFriend(){
    
        let friends = WBDemoViewController()
        
        navigationController?.pushViewController(friends, animated: true);
    
    }
    
    override func loadData(){
    
        listViewModel.loadStatus(pullup: self.ispull) { (isSuccess, shouldRefersh) in
            
            print("加载数据结束")
            //结束刷新
            self.refershControl?.endRefreshing()
            self.ispull = false
            
            if shouldRefersh
            {
                self.tableView?.reloadData()
            }
            
        }
    }
}

//设置界面
extension WBHomeViewController{
    
    override func setUpTableView() {
        
        super.setUpTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(myFriend))
    
        tableView?.register(UINib(nibName: "WBNormalStatusCell", bundle: nil), forCellReuseIdentifier: originalCellId)
        tableView?.register(UINib(nibName:"WBStatusRetweetedCell的", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        //设置行高
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        //取消分割线
        tableView?.separatorStyle = .none
        
        setUpNavTitle()
    }
    
    
    /// 设置导航栏标题
    private func setUpNavTitle() {
        
        let title = WBNetworkManager.shared.userAccount.screen_name
        
        let button = WBTitleButton(title: title)
        
        navItem.titleView = button
        
        button.addTarget(self, action:#selector(clickTitleButton), for: .touchUpInside)
    }
    
    @objc private func clickTitleButton(btn: UIButton){
        
        //设置选中状态
        btn.isSelected = !btn.isSelected
    }
}

extension WBHomeViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ///取出视图模型，根据视图模型判断可重用cell
        let vm = listViewModel.statusList[indexPath.row]
        
        let cellID = (vm.status.retweeted_status != nil) ? retweetedCellId : originalCellId
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! WBStatusCell
        
        
        cell.viewModel = vm
        
        
        return cell
    }
}
