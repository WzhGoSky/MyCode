//
//  WBBaseViewController.swift
//  微博
//
//  Created by Hayder on 16/10/25.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

//Swift写法更类似于多继承
//class WBBaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//Swift中利用extension 可以把函数按照功能分类管理，便于阅读和维护
//注意：
//1.extension 中不能有属性
//2.extension 中不能重写父类方法!重写父类方法，是子类的职责，扩展是对类的扩展

class WBBaseViewController: UIViewController{
    //用户没有就不创建
    var tableView: UITableView?
    
    var refershControl: UIRefreshControl?
    
    var ispull: Bool = false
    
    lazy var navBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var navItem : UINavigationItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false

        //2.设置UI
        setUpUI()
    
    }
    
    override var title: String?{
        
        didSet{
            
            navItem.title = title
        }
    }
    
    func loadData() -> () {
        
        //如果子类不实现任何方法，默认关闭刷新控件
        refershControl?.endRefreshing()
        
    }
}
// MARK: - 设置界面
extension WBBaseViewController {
 
    func setUpUI(){
    
        view.backgroundColor = UIColor.cz_random()
        
        setUpTableView()
        
        setUPNavigationBar()
    }
    
    private func setUPNavigationBar(){
        
        //添加导航条
        view.addSubview(navBar)
        
        //设置item
        navBar.items = [navItem]
        
        navBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray];
        
       

    }
    
    private func setUpTableView(){
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navBar);
        
        //设置代理方法
        tableView?.delegate = self;
        tableView?.dataSource = self;
        
        
        //设置tableViewframe
        tableView?.contentInset = UIEdgeInsets(top: navBar.bounds.height,
                                               left: 0,
                                               bottom:tabBarController?.tabBar.bounds.size.height ?? 49,
                                               right: 0)
        
        
        //refershControl
        refershControl = UIRefreshControl()
        
        tableView?.addSubview(refershControl!)
        
        refershControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension WBBaseViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    //在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //1.判断indexpath 是否是最后一行
        //(indexPatch.section (最大) /  indexpatch row最后一个)
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0{
            
            return
        }
        
        //3.行数
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !ispull{
            
            print("上拉刷新")
            ispull = true
            
            loadData()
        }
    }
}
