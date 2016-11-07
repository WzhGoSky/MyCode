//
//  ViewController.swift
//  图像的优化
//
//  Created by WZH on 16/11/7.
//  Copyright © 2016年 limpid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0, y: 0, width: 160, height: 160)
        
        let iv = UIImageView(frame: rect)
        
        iv.center = view.center
        
        view.addSubview(iv)
        
        //设置图像 -> PNG图片支持透明
        //-JPG 图片不支持透明，使用JPG
        let image = #imageLiteral(resourceName: "icon.png")
//        iv.image = image
        iv.image = avatarImage(image: image, size: rect.size,backColor: view.backgroundColor)
    }
    
//    //将给定的图像进行拉伸，并且返回新的图像
//    func avatarImage(image: UIImage, size: CGSize) -> UIImage? {
//        
//        let rect = CGRect(origin: CGPoint(), size: size)
//        //1.开启上下文
//        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
//        
//        //2.绘图 (在指定区域内拉伸屏幕)
//        image.draw(in: rect)
//        
//        //3.取得结果
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        
//        //4.关闭上下文
//        UIGraphicsEndImageContext()
//        
//        //5.返回结果
//        return result
//    }

    
    //将给定的图像进行拉伸，并且返回新的图像
    func avatarImage(image: UIImage, size: CGSize, backColor: UIColor?) -> UIImage? {
        
        let rect = CGRect(origin: CGPoint(), size: size)
        
        //1.开启上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        //背景填充
        backColor?.setFill()
        UIRectFill(rect)
        
        //1.实例化一个圆形的路径
        let path = UIBezierPath(ovalIn: rect);
        path.addClip()
       
        //2.绘图 (在指定区域内拉伸屏幕)
        image.draw(in: rect)

        //3.绘制内切的圆形
        UIColor.darkGray.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        //3.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()

        //4.关闭上下文
        UIGraphicsEndImageContext()

        //5.返回结果
        return result
    }
    

}

