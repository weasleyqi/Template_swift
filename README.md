#Template_swift

[![Build Status](https://travis-ci.org/weasleyqi/Template_swift.svg?branch=master)](https://travis-ci.org/weasleyqi/Template_swift)
##Release Note
---
##1.x Releases
- `1.0.0` Release [1.0.0](#100)

---

#####包含内容

- Multi-Target : 多版本管理
	- DEV : 开发人员使用
	- QA : QA使用
	- UAT : 客户验收测试
	- Pro : 正式环境发布
- Alamofire ：V3.0.0 (swift网络请求库)
	- XCode7.0+
	- iOS 8.0+
- Kingfisher : V2.1.0 (swift图片库)
	- Xcode7.0+
	- iOS 8.0+
- Remote Push Notifications
	- XCode7.0+
	- iOS 8.0+
- Check For Update
    - XCode7.0+
    - iOS 8.0+
- LocalAuthentication
    - XCode7.0+
    - iOS 9.0+
- 3DTouch
    - XCode7.0+
    - iOS 9.0+

##Multi-Target
####you can change the target name to adapt your project.
	Template - Product environment, release to public
	Template_UAT - UAT environment, release to customer to test
	Template_QA - QA environment, release to QA to test functions
	Template_DEV - Development environment, for devs to code.

>建议在项目开始的时候向iOS证书管理员申请多套证书，在target中配置好各个证书，然后在constant中配置好各个项目的配置项，在scheme中添加多个scheme，这样就会减少每次修改bundleid和修改证书带来的风险。

##Alamofire V3.0.0
###导入过程（使用模版的项目忽略此过程）
- 下载Alamofire代码包
- 将Alamofire文件夹copy到项目目录中
- 拖动Project文件至项目的Project文件下
- 选择某个target，general，在embedded Binaries添加Alamofire.framework文件
- `完成上述步骤，编译项目，确保项目编译成功。`

### Features

- [x] Chainable Request / Response methods
- [x] URL / JSON / plist Parameter Encoding
- [x] Upload File / Data / Stream / MultipartFormData
- [x] Download using Request or Resume data
- [x] Authentication with NSURLCredential
- [x] HTTP Response Validation
- [x] TLS Certificate and Public Key Pinning
- [x] Progress Closure & NSProgress
- [x] cURL Debug Output
- [x] Comprehensive Unit Test Coverage
- [x] [Complete Documentation](http://cocoadocs.org/docsets/Alamofire)

###Requirements

- XCode 7.2+
- iOS 8.0+

###Usage
####Basic http request
```swift
import Alamofire

Alamofire.request(.GET, "https://httpbin.org/get")
```
####Response Handling
```swift
Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
         .responseJSON { response in
             print(response.request)  // original URL request
             print(response.response) // URL response
             print(response.data)     // server data
             print(response.result)   // result of response serialization

             if let JSON = response.result.value {
                 print("JSON: \(JSON)")
             }
         }
```

> Networking in Alamofire is done _asynchronously_. Asynchronous programming may be a source of frustration to programmers unfamiliar with the concept, but there are [very good reasons](https://developer.apple.com/library/ios/qa/qa1693/_index.html) for doing it this way.

> Rather than blocking execution to wait for a response from the server, a [callback](http://en.wikipedia.org/wiki/Callback_%28computer_programming%29) is specified to handle the response once it's received. The result of a request is only available inside the scope of a response handler. Any execution contingent on the response or data received from the server must be done within a handler.

######[More information see origin Documents](https://github.com/Alamofire/Alamofire/blob/3.0.0/README.md)

##Kingfinsher V2.1.0
###导入过程（使用模版的项目忽略此过程）
- 下载Kingfisher代码包
- 将Kingfisher文件夹copy到项目目录中
- 拖动Project文件至项目的Project文件下
- 选择某个target，general，在embedded Binaries添加Kingfisher.framework文件
- `完成上述步骤，编译项目，确保项目编译成功。`

###Usage

```swift
import Kingfisher

imageView.kf_setImageWithURL(NSURL(string: "http://your_image_url.png")!)

```

```swift
imageView.kf_setImageWithURL(NSURL(string: "http://your_image_url.png")!, placeholderImage: nil)
```
######[More information see origin Documents](https://github.com/onevcat/Kingfisher/tree/2.1.0)
##Remote Push Notifications
```swift
//iOS 8+ 注册推送
let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
application.registerUserNotificationSettings(pushNotificationSettings)
application.registerForRemoteNotifications()
```
>In didRegisterForRemoteNotificationsWithDeviceToken function,get devicetoken,in didFailToRegisterForRemoteNotificationsWithError function, get register error message, in didReceiveRemoteNotification function, handle received messages.

##Check for Update
//检查更新 func checkForUpdate()
1. assigning variables (checkVersionUrl) with a default value 
2. assigning variables (downloadUrl) with a default value
3. request for check server version

```swift
let request = NSURLRequest(URL: NSURL(string: checkVersionUrl)!)
NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue()) { (response,data,connError) -> Void in
if let d = data{
let jsonstring = NSString(data: d, encoding: NSUTF8StringEncoding)! as String
dispatch_async(dispatch_get_main_queue(), { () -> Void in
print("jsonstring==\(jsonstring)")
let ver = "1.0"
self.checkVersion(ver)
})
```
4. get server version and this function calls the checkVersion() for download

##LocalAuthentication
```swift 
//指纹识别
call LocalAuthentication view controller
let localAutVC :LocalAutViewController = LocalAutViewController()
self.presentViewController(localAutVC, animated: true, completion: nil)
```
>In LocalAuthentication  func touchIDBtnAction() include validation logic
add code in  func touchIDBtnAction() 

##3DTouch 
```swift 
//3DTouch only run on iOS 9.0+
1. add func configShortCutItems() for configuring UIApplicationShortcutItem
2. add func for action of shortcutItem

>Test 3D Touch on Simulator in Xcode 7.0 . 

1. git clone https://github.com/DeskConnect/SBShortcutMenuSimulator.git
    cd SBShortcutMenuSimulator
    make
2. The following operation is performed in the SBShortcutMenuSimulator directory 
    xcrun simctl spawn booted launchctl debug system/com.apple.SpringBoard --environment DYLD_INSERT_LIBRARIES=$PWD/SBShortcutMenuSimulator.dylib
    xcrun simctl spawn booted launchctl stop com.apple.SpringBoard
 3. execute cmd   
    echo 'your App Bundle ID ' | nc 127.0.0.1 8000




