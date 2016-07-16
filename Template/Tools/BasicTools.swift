//
//  BasicTools.swift
//  Template
//
//  Created by Weasley Qi on 16/7/15.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import Foundation

/**
 去除字符串两端空格和回车
 
 - parameter orignString: 传入字符串
 
 - returns: 处理后的字符串
 */
func EscapeBlanksWithString(orignString:String) ->String {
    let endString:String = orignString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    return endString
}

/**
 将null字符串处理为空
 
 - parameter nullString: 传入字符
 
 - returns: 回传空字符
 */
func convertNullStringToEmpty(nullString:String?) ->String {
    var str :String?
    if(str == nil){
        str = ""
    }
    if(NSString.init(format: str!).isEqualToString("(null)")) {
        str = ""
    }
    if(NSString.init(format: str!).isEqualToString("<null>")) {
        str = ""
    }
    if(NSString.init(format: str!).isKindOfClass(NSNull)){
        str = ""
    }
    return str!
}
