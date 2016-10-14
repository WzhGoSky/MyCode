//
//  ViewController.swift
//  16.Swift3.0 - 循环引用
//
//  Created by WZH on 16/10/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var completionCallBack : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //block 中如果出现self. 要特别小心
        //’循环‘引用 单方向的引用是不会产生循环引用的
        //只是闭包对self 进行了copy,闭包执行完成后，会自动销毁，同时释放对self 对引用
        //- 同时需要self 对闭包引用
        loadData {
            
            print(self.view)
        }
        
        //解除循环引用，需要打断链条
        //方法1.使用 OC 方法
        //细节1 var  weak 只能修饰var，不能修饰let
        // 'weak' must be a mutable variable, because it may change at runtime
        // weak 可能会在运行时被修改->指向的对象一旦被释放，就会自动设置为nil
        //ViewController?
//       weak var weakSelf = self
//        loadData {
//            
//            //细节 2
//            //解包有两种方式的解包
//            // ？可选解包 -> 如果self已经被释放，不会像对象发送getter的消息,更加安全
//            // ! 强行解包 -> 如果self已经被释放，强行解包会导致崩溃
//            
//            /**
//             weakSelf?.view - 只是单纯的发送消息，没有计算
//             强行解包，因为需要计算，可选项不能直接参与到计算，
//             */
//            print(weakSelf?.view)
//        }
        
        //方法2 - Swift 的推荐方法
        //[weak self] 表示 {} 中的所有self 都是弱引用，需要解包
        loadData { [weak self] in
            
            print(self?.view)
        }
        
        //方法3 - Swift 的另外一个用法（了解）
        //[unowned self] 表示{} 中的所有self 都是assign的，不会强引用，但是，如果对象释放，指针地址不会变化
        //如果对象呗释放，继续调用，就会出现野指针
//        loadData { [unowned self] in
//            
//            print(self.view)
//        }
    }
    
    func loadData(complete: @escaping () -> ()) {
        
        //使用属性记录闭包 (循环引用)
        completionCallBack = complete;
        
        DispatchQueue.global().async { 
            
            
            DispatchQueue.main.async(execute: { 
                
                complete()
                
            })
        }
    }
    
    //类似于 OC 的dealloc
    deinit {
        
        print("我去了")
    }
}

