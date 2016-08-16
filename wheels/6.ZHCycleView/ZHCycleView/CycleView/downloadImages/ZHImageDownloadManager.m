//
//  ZHImageDownloadManager.m
//  ZHCycleView
//
//  Created by WZH on 16/8/16.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ZHImageDownloadManager.h"

static id _instance;

@implementation ZHImageDownloadManager

//创建一个单例
+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[ZHImageDownloadManager alloc] init];
        
    });
    
    return _instance;
}

- (NSCache *)images
{
    if (!_images) {
        
        _images = [[NSCache alloc] init];
        _images.countLimit = 100;
    }
    
    return _images;
}

- (NSMutableDictionary *)operations
{
    if (!_operations) {
        
        _operations = [[NSMutableDictionary alloc] init];
    }
    
    return _operations;
}

- (NSOperationQueue *)queue
{
    if (!_queue) {
        
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return _queue;
}

@end
