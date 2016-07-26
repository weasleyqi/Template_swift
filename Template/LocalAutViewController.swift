//
//  LocalAutViewController.swift
//  Template
//
//  Created by Louis.She on 16/7/25.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import UIKit
import LocalAuthentication

class LocalAutViewController: UIViewController{
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let touchIDBtn = UIButton()
        touchIDBtn.frame = CGRectMake(20, 70, screenWidth - 20*2, 50)
        touchIDBtn.backgroundColor = UIColor .redColor()
        touchIDBtn.setTitle("指纹解锁", forState: UIControlState.Normal)
        touchIDBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        touchIDBtn.addTarget(self, action: Selector("touchIDBtnAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(touchIDBtn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func touchIDBtnAction(sender: UIButton){
        let laContext = LAContext()
        var error:NSError?
        if laContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            laContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason: "请验证已有的指纹",
                reply: {(success: Bool, error: NSError?) in
                    
                    if success {
                        MTLog("验证指纹成功")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.dismissViewControllerAnimated(true, completion: { () -> Void in})
                        })
                    } else {
                        switch error?.code {
                        case LAError.AuthenticationFailed.rawValue?:
                            MTLog("授权失败")
                        case LAError.UserCancel.rawValue?:
                            MTLog("用户取消验证Touch ID")
                        case LAError.UserFallback.rawValue?:
                            MTLog("用户点击输入密码")
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                self.showPasswordAlert()
                            })
                        case LAError.SystemCancel.rawValue?:
                            MTLog("系统取消验证Touch ID")
                        case LAError.PasscodeNotSet.rawValue?:
                            MTLog("系统未设置密码")
                        case LAError.TouchIDNotAvailable.rawValue?:
                            MTLog("设备Touch ID不可用")
                        default:
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                self.showPasswordAlert()
                            })
                        }
                    }
            })
            
        } else {
            let alert = UIAlertView(title: "设备不支持指纹识别", message: "", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    
    private func showPasswordAlert() {
        let passwordAlert: UIAlertController = UIAlertController(title:"指纹验证选择输入密码", message:"请输入手机密码", preferredStyle:.Alert)
        passwordAlert.addTextFieldWithConfigurationHandler({ (textField: UITextField) in
            textField.secureTextEntry = true
        })
        
        passwordAlert.addAction(UIAlertAction(title: "确定", style: .Default, handler: {action in
            let password = passwordAlert.textFields?.first?.text
            if let pw = password {
                MTLog("输入密码正确，密码为： \(pw)")
            }
        }))
        
        passwordAlert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: {action in
            MTLog("取消输入密码")
        }))
        
        self.presentViewController(passwordAlert, animated: true, completion: nil)
    }
    
    
}