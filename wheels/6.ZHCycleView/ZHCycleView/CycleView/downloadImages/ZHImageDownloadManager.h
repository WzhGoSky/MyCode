//
//  ZHImageDownloadManager.h
//  ZHCycleView
//
//  Created by WZH on 16/8/16.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHImageDownloadManager : NSObject

@property (strong,nonatomic)NSCache *images;

@property (strong,nonatomic)NSMutableDictionary *operations;

@property (strong,nonatomic)NSOperationQueue *queue;

//创建一个单例
+ (instancetype)defaultManager;

@end
