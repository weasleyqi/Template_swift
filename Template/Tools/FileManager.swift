//
//  FileManager.swift
//  Template
//
//  Created by Louis.She on 16/8/1.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import UIKit
import Foundation

class FileManager{
    
    class var sharedInstance: FileManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: FileManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = FileManager()
        }
        return Static.instance!
    }
    
    //获取Home目录
    class func  getHomeSubDirs() ->Array<String>{
        let homeSubDirs :Array = NSFileManager.defaultManager().subpathsAtPath(NSHomeDirectory())!
        return homeSubDirs as Array
    }
    //获取Document目录
    class func  getDocumentPath()->String{
        var path:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        return path[0] as String
    }
    //获取Library目录
    class func  getLibraryPath()->String{
        var path:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return path[0] as String
    }
    //获取Cache目录
    class func  getCachePath()->String{
        var path:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return path[0] as String
    }
    //获取Temporary目录
    class func  getTemporaryPath()->String{
        return NSTemporaryDirectory() as String
    }
    
    //获取目录下所有文件
    class func getFilesAtPath(dirPath:String)->Array<String>{
        let fileArray = NSFileManager.defaultManager().subpathsAtPath(dirPath)
        return fileArray! as Array
    }

    //获取文件各项属性
    class func getfileAttributes(filePath:String)->Dictionary<NSObject,AnyObject>{
        
        var fileAttributes : [NSObject : AnyObject]?
        do {
            try fileAttributes = NSFileManager.defaultManager().attributesOfItemAtPath(filePath)
            
        } catch let error as NSError {
            MTLog(error.localizedDescription)
            return [:]
        }
        return fileAttributes!
    }
    
    //检查目录或文件是否存在
    class func isFileExist(filePath : String) -> Bool{
        let fileMgr = NSFileManager.defaultManager()
        return fileMgr.fileExistsAtPath(filePath)
    }
    
    //创建目录
    class func createDirectory(directoryName : String!)-> Bool{
        let documents:String = self.getDocumentPath()
        var dirPath = documents + "/";
        dirPath += directoryName
        //
        let fileMgr = NSFileManager.defaultManager()
        do {
            try fileMgr.createDirectoryAtPath(dirPath, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            MTLog(error.localizedDescription)
            return false
        }
    }
    
    //创建目录和文件
    class func createFile(filePath:String! , fileName:String!, content:String)-> Bool{
        
        if(!self.isFileExist(filePath)){
            self.createDirectory(filePath)
        }
        
        let path = self.getDocumentPath() + "/\(filePath)" + "/\(fileName)"
        
        if(!self.isFileExist(path)){
 
            let fileMgr = NSFileManager.defaultManager()
            // content of the file
            let stringContent = content
            // convent text to NSData
            let stringNSData = stringContent.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            // save text
            if( fileMgr.createFileAtPath(path, contents: stringNSData, attributes: nil)){
                return true
            }else{
                return false
            }
        }
        return false
    }
    
    //保存NSDictionary数据创建Plist文件
    class func saveDictToFile(filePath:String ,dic :NSDictionary) ->Bool{
        if(dic.writeToFile(filePath , atomically: true)){
            return true
        }else{
            return false
        }
    }
    
    
    //删除Document目录下目录和文件
    class func removeFileFromDocument(filePathName: String!)->Bool{
        let exist:Bool = NSFileManager.defaultManager().fileExistsAtPath(self.getDocumentPath()+"/"+filePathName)
        if exist {
            let filePath : String = self.getDocumentPath()+"/"+filePathName
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePath)
                return true
            } catch let error as NSError {
                MTLog(error.localizedDescription)
                return false
            }
        }else {
            return false
        }
    }
    
    
    //保存图片
    class func saveImage(dirPath:String ,uid:String,image:UIImage) -> Bool{
        
        let directoryURL = NSURL(fileURLWithPath: dirPath, isDirectory: true)
        let url = directoryURL.URLByAppendingPathComponent("\(uid).png")
        let bSuccess = UIImagePNGRepresentation(image)!.writeToURL(url, atomically: true)
        if (bSuccess){
            return true
        }else {
            return false}
    }
    
    //获取本地图片
    class func getImage(dirPath:String ,uid:String)->UIImage?{
 
        let directoryURL = NSURL(fileURLWithPath: dirPath, isDirectory: true)
        let url = directoryURL.URLByAppendingPathComponent("\(uid).png")
        if let data = NSData(contentsOfURL: url){
            return UIImage(data: data)
        }
        return nil
    }
    
    

    //文件移动和重命名
    class func moveFileFromToPath(fromPath:String! ,toPath:String!){
        do{
            try NSFileManager.defaultManager().moveItemAtPath(fromPath, toPath: toPath)
        }catch let error as NSError {
            MTLog(error.localizedDescription)
        }
    }

    
    //文件拷贝和重命名
    class func copyFileFromToPath(fromPath:String! ,toPath:String!){
        do{
            try NSFileManager.defaultManager().copyItemAtPath(fromPath, toPath: toPath)
        }catch let error as NSError {
            MTLog(error.localizedDescription)
        }
    }
    
}