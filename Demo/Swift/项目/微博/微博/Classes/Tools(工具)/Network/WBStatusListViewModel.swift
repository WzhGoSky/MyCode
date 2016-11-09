//
//  WBStatusListViewModel.swift
//  微博
//
//  Created by Hayder on 2016/11/1.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import Foundation
import SDWebImage

///微博数据列表视图模型

/**
    父类的选择
 
 - 如果类需要使用‘kvc’ 或者字典转模型框架设置对象值，类就需要继承自NSObject
 - 如果类只是包装了一些代码逻辑(写了一些函数)，可以不用任何父类，好处:更加轻量级
 - 提示：如果OC 写，一律都继承自NSObject
 
 任务:1.负责微博的数据处理
 */
fileprivate let maxPullUpTryTimes = 3

class WBStatusListViewModel {
    
    ///微博模型数组懒加载
    lazy var statusList = [WBStatusViewModel]()
    
    private var pullErrorTimes = 0
    
    //是否刷新表格
    func loadStatus(pullup:Bool , completion:@escaping(_ isSuccess: Bool, _ shouldRefersh: Bool)->()) {
        
        //1.判断是否是上拉刷新，同时检查刷新错误
        if pullup && (pullErrorTimes > maxPullUpTryTimes) {
            
             completion(true, false)
            
            return
        }
        
        //since_id 下拉。 取出数组中第一条微博的id
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        
        //max_id上拉刷新，取出数组中最后一条微博的id
        let max_id = pullup ? (statusList.last?.status.id ?? 0) : 0
        
        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id){ (list, isSuccess) in
            
            //判断网络请求是否成功
            if !isSuccess{
                
                completion(false, false)
                
                return
            }
            
            //1.定义结果可变数组
            var array = [WBStatusViewModel]()
            
            //2.遍历服务器返回字典数组，字典转模型
            for dict in list ?? []
            {
                //1.创建微博模型
                guard let model = WBStatus.yy_model(with: dict) else{
                    
                    continue
                }
                
                //2.将model添加到数组
                array.append(WBStatusViewModel(model: model))
            }
            
//            print("刷新了\(array.count)条数据,\(array)")
            
            //2.拼接数据
            
            if pullup {
                
                self.statusList += array
                
            }else
            {
                //下拉刷新,应在将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
           //3.判断上拉刷新的数据量
            if pullup && array.count == 0{
                
                self.pullErrorTimes += 1
                
                completion(isSuccess, false)
                
            }else
            {
                self.cacheSingleImage(list: array,completion: completion)
            }
            
            
        }
    }
    
    ///缓存本次下载微博数据数组中的单张图像
    private func cacheSingleImage(list: [WBStatusViewModel],completion:@escaping(_ isSuccess: Bool, _ shouldRefersh: Bool)->())
    {
        //调度组
        let group = DispatchGroup()
        
        
        //记录数据长度
        var length = 0
        //遍历数组，查找微博数组中有单张图像的，进行缓存
        for vm in list{
            
            if vm.picUrls?.count != 1 {
                
                continue
            }
            
            //2.获取url 代码到此，数组中有且只有一张图
            guard let pic = vm.picUrls?[0].thumbnail_pic,
                  let url = URL(string: pic) else{
                
                continue
            }
            
            //下载图像
            //downloadImage 是SDWebImage的核心方法
            //图像下载完成之后，会自动保存在沙河中， 文件路径是url的md5
            //如果沙盒中已经存在缓存的图像，后续使用SD通过URL加载图像，都会加载本地沙河的图像
            //不会发起网络请求，同时，调用方法，同样会调用
            //方法还是同样的方法，调用还是同样的调用，不过内部不会再做处理了
            //注意点：如果要缓存的图像，累计很大，要找的后台要接口
            
            //入组
            group.enter()
            
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image,_, _, _, _) in
            
                //将图像转换成二进制图像
                if let image = image,
                    let data = UIImagePNGRepresentation(image){
                    
                    //NSData 是length属性
                    length += data.count
                    
                    //图像缓存成功，更新配图视图的大小
                    vm.updateSingleImageSize(image: image)
                }
                
                //出组
                group.leave()
            })
        }
        
        //监听调度组
        group.notify(queue: DispatchQueue.main){
            
            print("图片总大小 \(length / 1024)k")
            
            completion(true, true)
        }
    }
    
}
