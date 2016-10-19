//
//  listController.swift
//  25.Swift3.0 - 私人通讯录
//
//  Created by Hayder on 16/10/18.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import UIKit

class listController: UITableViewController {

    //联系人数组
    var personlist = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData { (list) in
            
            print(list)
            
            //拼接数组,闭包中定义好的代码在需要的时候执行，需要self. 指定语境
            self.personlist += list;
            
            self.tableView.reloadData()
        }
    }
  
    
    // 模拟异步，利用闭包回调
    private func loadData(completion:@escaping (_ list : [Person]) -> ()){
        
        DispatchQueue.global().async { 
            
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM = [Person]()
            
            for i in 0..<20
            {
                let p = Person()
                
                p.name = "zhangsan - \(i)"
                p.phone = "1860" + String(format: "%o6d", arc4random_uniform(1000000))
                p.title = "Boss"
                
                arrayM.append(p)
            }
            
            //主线程回调
            
            DispatchQueue.main.async(execute: { 
                
                //回调，执行闭包
                
                completion(arrayM)
            })
        }
    }
    
    //MARK: - 数据源方法
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        
        cell.textLabel?.text = personlist[indexPath.row].name
        cell.detailTextLabel?.text = personlist[indexPath.row].phone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "list2Detail", sender: indexPath)
        
    }
    @IBAction func newPerson(_ sender: AnyObject) {
        
         performSegue(withIdentifier: "list2Detail", sender: nil)
        
    }
    
    //控制器跳转方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //做类型转换 as
        //Swift中String之外，绝大多数使用 as 需要？ /!
        //as? / as! 直接根据前面的返回值来决定
        //注意 if let 、guard let 判空语句，一律使用as?
        let vc = segue.destination as! DetailController
        
        //设置选中person, indexpath
        
        if let indexpath = sender as? IndexPath {
            
            vc.person = personlist[indexpath.row]
            
            //设置编辑完成的闭包
            vc.completionCallBack = {
                
                self.tableView.reloadRows(at: [indexpath], with: .automatic)
            }
        }else //新建个人记录
        {
            vc.completionCallBack = { [weak vc] in
                
                //获取明细控制器的person
                guard let person = vc?.person else {
                    
                    return
                }
                
                //插入到数据的顶部
                self.personlist.insert(person, at: 0)
                
                //刷新
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
}
