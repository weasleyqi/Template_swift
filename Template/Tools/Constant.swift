//
//  Constant.swift
//  Template
//
//  Created by Weasley Qi on 16/7/15.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//
//  此为基础类，主要提供相关全局配置的变量，比如服务器地址、相关key等

import Foundation
import UIKit

/**
 * 根据不同的版本设定不同的server url及其他配置项
 */
#if PRODUCTION_VERSION  //正式版本
    let server = ""
#elseif UAT_VERSION  //UAT版本
    let server = ""
#elseif QA_VERSION  //测试版本
    let server = ""
#elseif DEV_VERSION  //开发版本
    let server = ""
#endif

/// 屏幕宽度
let screenWidth = UIScreen.mainScreen().bounds.size.width
/// 屏幕高度
let screenHeight = UIScreen.mainScreen().bounds.size.height
/// app main version
let mainVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
/// app build version
let buildVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]
/// device name
let appDisplayName = UIDevice.currentDevice().name
/// iOS系统版本
let iosVersion : NSString = UIDevice.currentDevice().systemVersion
/// 设备udid
let identifierNumber = UIDevice.currentDevice().identifierForVendor
/// 设备名称
let systemName = UIDevice.currentDevice().systemName
/// 设备型号
let deviceModel = UIDevice.currentDevice().model
/// 设备区域化型号 如 A1533
let deviceLocalizedModel = UIDevice.currentDevice().localizedModel


/**
 自定义log
 
 - parameter message:    输出信息
 - Out：类名.方法名.行数.输出信息
 - Usage : MTLog("Test MTLog")
 */
func MTLog<T>(message: T, fileName: String = __FILE__, methodName: String =  __FUNCTION__, lineNumber: Int = __LINE__)
{
    #if PRODUCTION_VERSION
    #else
        let str : String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(str)\(methodName)[\(lineNumber)]:\(message)")
    #endif
}