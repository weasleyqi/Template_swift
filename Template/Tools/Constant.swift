//
//  Constant.swift
//  Template
//
//  Created by Weasley Qi on 16/7/15.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//
//  此为基础类，主要提供相关全局配置的变量，比如服务器地址、相关key等

import Foundation

/**
 * 根据不同的版本设定不同的server url及其他配置项
 */
#if PRODUCTION_VERSION  //正式版本
    let Server = ""
#elseif UAT_VERSION  //UAT版本
    let Server = ""
#elseif QA_VERSION  //测试版本
    let Server = ""
#elseif DEV_VERSION  //开发版本
    let Server = ""
#endif

