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
    
    //访客视图信息字典
    var visitorInfo: [String : String]?

    //用户没有就不创建
    var tableView: UITableView?
    
    var refershControl: UIRefreshControl?
    
    var ispull = false
    
    var userLogin = true
    
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

//MARK:- 访客视图监听方法
extension WBBaseViewController{
    
    @objc fileprivate func login(){
        
        print("登录")
    }
    
    @objc fileprivate func register(){
        
        print("注册")
    }
    
}
// MARK: - 设置界面
extension WBBaseViewController {
 
   fileprivate func setUpUI(){
    
        view.backgroundColor = UIColor.cz_random()
        
        userLogin ? setUpTableView() : setUpVistorView()
        
        setUPNavigationBar()
    }
    
    private func setUPNavigationBar(){
        
        //添加导航条
        view.addSubview(navBar)
        
        //设置item
        navBar.items = [navItem]
        
        //1.设置NavBar 整个背景的的渲染颜色
        navBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        //2.设置navBar字体颜色
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        //3.设置系统按钮的文字渲染颜色
        navBar.tintColor = UIColor.orange
        
    }
    
    //子类重写此方法，因为子类不需要关心用户登录之前的逻辑
    func setUpTableView(){
        
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
    
    private func setUpVistorView(){
        
        let vistorView = WBVistorView(frame: view.bounds)
        
        view.insertSubview(vistorView, belowSubview: navBar)
        
        //1.设置访客视图的信息
        vistorView.visitorInfo = visitorInfo
        
        //2.添加范文视图按钮的监听方法
        vistorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        vistorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        //3.设置导航陶按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
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
