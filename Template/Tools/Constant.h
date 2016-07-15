//
//  Constant.h
//  Template
//
//  Created by Weasley Qi on 16/7/12.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef Template_DEV //开发环境

#elif Template_QA //QA环境

#elif Template_UAT //UAT环境

#elif Template //正式环境

#endif




/************************** 常用宏定义 Start **************************/

/**
 *  os Version
 */
#define OsVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  Screen Height
 */
#define ScreenHEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  Screen Width
 */
#define ScreenWIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  Color With RGB
 *  Usage: UIColorFromRGB(#999999,1)
 */
#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]


/************************** 常用宏定义 End **************************/

/**
 *  Development Module log in consule
 */
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif /* Constant_h */
