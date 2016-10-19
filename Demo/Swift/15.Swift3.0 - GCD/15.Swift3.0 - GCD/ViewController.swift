//
//  ViewController.swift
//  15.Swift3.0 - GCD
//
//  Created by WZH on 16/10/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadData { (result) in
        
            print(result)
        }
        
        //"尾"随闭包
        //如果函数的最后一个参数是闭包，函数参数可以提前结束，最后一个参数直接使用{}包装闭包的代码
        loadData { (result) in
            
            print(result)
        }
        
        //按照函数本身编写的结果
        // 关于尾随闭包
        //1. 能看懂
        loadData(completion: { (result) -> () in
            
            
        })
        
    }
    
    /**
    在异步执行任务，获取结果，通过闭包block 回调
    闭包的应用场景和 block 完全一致
    @noescaping 作用:指明这个闭包是不允许逃逸出这个函数的。非逃逸闭包只能在函数体中执行，不能脱离函数体执行。可以使编译器明确的知道运行时的上下文环境，进而做出优化
    
     比如， sort(_:) 方法可以接受一个用于元素比较的闭包参数，它被指明为 @noescape ，因为排序结束后这个闭包就没用了。
     
     一般情况下，一些异步函数会使用逃逸闭包。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。
     
     @escaping 逃逸闭包
     */
    func loadData(completion:@escaping (_ result : [String] ) -> ()) -> () {
        
        //将任务添加到队列，指定执行任务的函数
        //翻译:队列调度任务（block/闭包），以同步/异步的方式执行
        DispatchQueue.global().async {
            
            print("耗时操作 \(Thread.current)")
            
            //休眠
            Thread.sleep(forTimeInterval: 1.0)
            
            //获取结果
            let json = ["头条","八卦","出大事了"]
            
            //主队列回调
            DispatchQueue.main.async(execute: { 
                
                print("主线程更新UI \(Thread.current)")
                
                //回调
                completion(json)
            })
        }
    }
    
    
}

