//
//  AppDelegate.swift
//  Template
//
//  Created by Weasley Qi on 16/7/12.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIAlertViewDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //iOS 8+ 注册推送
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
        
        //检查更新
        checkForUpdate()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //注册推送成功获取设备号
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token : String = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
        //获取到token
        MTLog("token==\(token)")
    }
    
    //注册推送失败
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        MTLog(error.localizedDescription)
    }
    
    //收到推送消息时调用该方法进行处理
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        MTLog("userInfo==\(userInfo)")
    }
    
    //检查更新
    func checkForUpdate(){
        
        Alamofire.request(.GET, checkVersionUrl)
            .response { (request, response, data, error) in
                if(data!.length == 0 || error != nil){
                    MTLog("connError==\(error!.localizedDescription)")
                }else{
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] {
                            MTLog(json)
                            
                            if let d = data{
                                let jsonstring = NSString(data: d, encoding: NSUTF8StringEncoding)! as String
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    MTLog("jsonstring==\(jsonstring)")
                                    //TODO 从json中获取服务器端版本号，以下ver需要赋值
                                    let ver = "1.2"
                                    
                                    //compare versions
                                    if ver.compare(mainVersion) == NSComparisonResult.OrderedDescending {
                                        let alertView = UIAlertView.init(title: "Update", message: "New version for update", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
                                        alertView.show()
                                    }
                                })
                            }
                        }
                    } catch let err as NSError {
                        MTLog(err.localizedDescription)
                    }
                }
        }
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if(buttonIndex == 1){
            UIApplication.sharedApplication().openURL(NSURL(string: downloadUrl)!)
        }
        else {}
    }
    //检查更新end
}

