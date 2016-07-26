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
    let downloadUrl = ""
    let checkVersionUrl = ""
#elseif UAT_VERSION  //UAT版本
    let server = ""
    let downloadUrl = ""
    let checkVersionUrl = ""
#elseif QA_VERSION  //测试版本
    let server = ""
    let downloadUrl = ""
    let checkVersionUrl = ""
#elseif DEV_VERSION  //开发版本
    let server = ""
    let downloadUrl = ""
    let checkVersionUrl = ""
    
#endif

/// 屏幕宽度
let screenWidth :Int = Int(UIScreen.mainScreen().bounds.size.width)
/// 屏幕高度
let screenHeight :Int = Int(UIScreen.mainScreen().bounds.size.height)
/// app main version
let mainVersion :String = String(NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"])
/// app build version
let buildVersion :String = String(NSBundle.mainBundle().infoDictionary!["CFBundleVersion"])
/// device name
let appDisplayName :String = String(UIDevice.currentDevice().name)
/// iOS系统版本
let iosVersion : String = String(UIDevice.currentDevice().systemVersion)
/// 设备udid
let identifierNumber :String = String(UIDevice.currentDevice().identifierForVendor)
/// 设备名称
let systemName :String = String(UIDevice.currentDevice().systemName)
/// 设备型号
let deviceModel :String = String(UIDevice.currentDevice().model)
/// 设备区域化型号 如 A1533
let deviceLocalizedModel :String = String(UIDevice.currentDevice().localizedModel)


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