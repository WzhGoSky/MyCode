//
//  WBCommon.swift
//  微博
//
//  Created by Hayder on 2016/11/2.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

import Foundation

//MARK:- 应用程序信息
///应用程序ID
let WBAppKey = "2255030609"
///应用程序加密信息
let WBAppSecret = "ec743488b8385151f50ea680fca219db"
///回调地址 - 登陆完成跳转的URL
let WBRedirectURI = "http://www.baidu.com"


//MARK:- 全局通知定义
//用户需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"

let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"

//MARK:微博配图视图常量
//1.配图视图的宽度
//配图视图外侧的间距
let WBStatusPictureViewOutterMargin = CGFloat(12)
//配图视图内容部图像视图的间距
let WBStatusPictureViewInnerMargin = CGFloat(3)

//1.屏幕的宽度
let WBStatusPictureViewWidth = UIScreen.cz_screenWidth() - 2*WBStatusPictureViewOutterMargin

//每个Item默认的宽度
let WBStatusPictureItemWith = (WBStatusPictureViewWidth - 2*WBStatusPictureViewInnerMargin)/3

