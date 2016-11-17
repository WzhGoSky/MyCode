//
//  ViewController.swift
//  Emoticon
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

/**
 1.黄色的文件夹，打包的时候不会建立目录，用于存放程序文件
    - 素材文件不允许重名
 2.蓝色的文件夹，打包的时候会建立目录，可以分目录的存储素材文件
    - 素材可以重名
    - 应用场景1:游戏的场景
    - 应用场景2:白天/夜间模式
    - 切忌: 不要把程序文件放在蓝色的文件夹中!
 3.Bundle(白色)
    - 通常用在第三方框架的素材
    - 可以按照黄色文件夹的方式拖拽，同时会保留住目录结构
    - 可以避免文件重名
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print( WBEmoticonManager.shared.packages)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

