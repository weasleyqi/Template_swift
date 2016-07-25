//
//  AdvancedTools.swift
//  Template
//
//  Created by Weasley Qi on 16/7/19.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import Foundation

enum ValidatedType {
    case Email
    case PhoneNumber
}
func ValidateText(validatedType type: ValidatedType, validateString: String) -> Bool {
    do {
        let pattern: String
        if type == ValidatedType.Email {
            pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        }
        else {
            pattern = "^1\\d{10}$"
        }
        
        let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        let matches = regex.matchesInString(validateString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, validateString.characters.count))
        return matches.count > 0
    }
    catch {
        return false
    }
}

/**
 校验邮箱是否有效
 
 - parameter vStr: 邮箱地址
 
 - returns: true／false
 */
func EmailIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.Email, validateString: vStr)
}

/**
 校验手机号码是否有效
 
 - parameter vStr: 手机号码
 
 - returns: true／false
 */
func PhoneNumberIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.PhoneNumber, validateString: vStr)
}