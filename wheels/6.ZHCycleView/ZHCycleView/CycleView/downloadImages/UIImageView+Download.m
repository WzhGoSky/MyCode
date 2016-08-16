//
//  UIImageView+Download.m
//  ZHCycleView
//
//  Created by WZH on 16/8/16.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "UIImageView+Download.h"


@implementation UIImageView (Download)

//下载网络图片
- (UIImageView *)setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    ZHImageDownloadManager *manager = [ZHImageDownloadManager defaultManager];
    
    //从缓存中取出图片
    UIImage *cacheImage = [manager.images objectForKey:url];
    
    if(cacheImage)
    {
        self.image = cacheImage;
    }else
    {
        //1.获取沙盒中cache路径
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //获取图片名字的最后一个节点作为图片名
        NSString *imageName = [url lastPathComponent];
        NSString *fullPath = [cachePath stringByAppendingPathComponent:imageName];
        
        //2.从磁盘中读取数据
        NSData *data = [NSData dataWithContentsOfFile:fullPath];
        
        if (data) { //找到数据了
            UIImage *image = [UIImage imageWithData:data];
            self.image = image;
            
        }else //进行下载
        {
            //1.先放一张占位图片
            self.image = placeholderImage;
            
            //2.去字典中查找下该图片是否正在被下载
            NSBlockOperation *download = [manager.operations objectForKey:url];
            
            if (!download) { //没有被下载
                
                //进行下载
                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    
                    //1.获取url路径
                    NSURL *imageUrl = [NSURL URLWithString:url];
                    
                    //2.下载图片
                    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
                    
                    //3.根据二进制生成一张图片
                    UIImage *image = [UIImage imageWithData:data];
                    
                    if (image == nil) {
                        
                        NSLog(@"该图片路径%@下没有图片",url);
                        return ;
                    }
                    
                    //将图片保存一份到内存里面
                    [manager.images setObject:image forKey:url];
                    
                    [data writeToFile:fullPath atomically:YES];
                    
                    //主队列中设置图片
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                      
                        self.image = image;
                    }];
                }];              
                //将下载的操作添加到队列中
                [manager.queue addOperation:download];
                //将下载的操作添加一份到缓存中，防止重复下载图片
                [manager.operations setObject:download forKey:url];
            }
        }
    }
    
    return self;
}


@end
