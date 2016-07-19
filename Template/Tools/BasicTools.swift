//
//  BasicTools.swift
//  Template
//
//  Created by Weasley Qi on 16/7/15.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//
// 去除字符串两端的空格和回车
// null字符串处理
// Base64加密／解密
// MD5加密
// 手机号码校验

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

/**
 Base64 加密
 
 - parameter str: 需要加密的字符串
 
 - returns: 加密后的字符串
 */
func base64EnCode(str:String) -> String {
    let plainData = str.dataUsingEncoding(NSUTF8StringEncoding)
    
    let base64String = plainData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.init(rawValue: 0))
    
    return base64String!
}

/**
 Base64 解密
 
 - parameter base64EncodedString: base64加密后的字符串
 
 - returns: base64解密后的字符串
 */
func base64DeCode(base64EncodedString:String) -> String {
    let decodedData = NSData(base64EncodedString: base64EncodedString, options:NSDataBase64DecodingOptions.init(rawValue: 0))
    
    let decodedString = String(data: decodedData!, encoding: NSUTF8StringEncoding)
    
    return decodedString!
}

/**
 MD5 加密
 
 - usage： var str ＝ orignString.md5()
 
 - extension了字符串后就变成了字符串的一个自带方法
 
 - returns: MD5加密后的字符串
 */
extension String{
    func md5() ->String!{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        return String(format: hash as String)
    }
}

/**
 手机号码正则表达式校验
 
 - parameter num: 手机号码字符串
 
 - returns: true／false
 */
func isTelNumber(num:NSString)->Bool {
    let mobile = "^1\\d{10}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if (regextestmobile.evaluateWithObject(num) == true) {
        return true
    }
    else {
        return false
    }
}
