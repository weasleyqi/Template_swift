//
//  ViewController.swift
//  Template
//
//  Created by Weasley Qi on 16/7/12.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import UIKit
import Kingfisher
import PullToRefresh

private let PageSize = 20

class ViewController: UIViewController {

    @IBOutlet weak var testImage: UIImageView!
    
    private var dataSourceCount = PageSize
    private var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testImage.kf_setImageWithURL(NSURL(string: "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg")!, placeholderImage: UIImage(named: "1.jpg"))
        
        MTLog("Test MTLog")
        
        let str = "test123"
        let str_Md5 = str.md5()
        MTLog(str_Md5)
        
        
        //test FileManager
        MTLog("====Test FileManager Begin====")
        
        MTLog("DocumentPath:\(FileManager.getDocumentPath())")
        
        //创建Document目录下Images文件夹
        FileManager.createDirectory("Images")
        FileManager.createDirectory("MyDoc")
        //
        //保存图片到本地Images文件夹
        let path:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        let imagePath = path[0] + "/Images"
        MTLog("==== \(imagePath)")
        let img :UIImage = UIImage.init(named: "1.jpg")!
        FileManager.saveImage(imagePath,uid: "1111-2222-3333-4444",image: img)
        
        //加载本地图片显示View中
        let image :UIImage = FileManager.getImage(imagePath,uid: "1111-2222-3333-4444")!
        let imageView : UIImageView = UIImageView.init(frame: CGRectMake(60, 300, 200, 160))
        self.view.addSubview(imageView)
        imageView.image = image
        
        //创建本地文件
        if(FileManager.createFile("MyDoc", fileName: "sm.txt",content: "hello swift!")){
            MTLog("====create file success ")
        }else{
            MTLog("====create file failed ")
        }
        
        //获取目录下所有文件
        let dirPath = FileManager.getDocumentPath() + "/MyDoc"
        let fileArr = FileManager.getFilesAtPath(dirPath)
        print ("====\(fileArr)")
        
        //检查目录或文件是否存在
        if (FileManager.isFileExist(FileManager.getDocumentPath() + "/MyDoc")){
            MTLog("====file exists")
        }else{
            MTLog("====file is not exists")
        }
        //获取文件属性
        let fileAttributes = FileManager.getfileAttributes(FileManager.getDocumentPath() + "/MyDoc/sm.txt")
        MTLog("====file Attributes ====\n \(fileAttributes) ")

        //拷贝重命名
        let filePath = FileManager.getDocumentPath() + "/MyDoc/sm.txt"
        let filePath2 = FileManager.getDocumentPath() + "/Images/sm.txt"
        FileManager.copyFileFromToPath(filePath, toPath:filePath2)
        
        //保存Dictionary数据Plist文件
        let dic = NSDictionary(objects: ["1111","2222","3333"], forKeys: ["1","2","3"])
        if( FileManager.saveDictToFile(FileManager.getDocumentPath() + "/dictionary.plist", dic:dic)){
            MTLog("====save dictionary success")
        }else{
            MTLog("====save dictionary failed")
        }
        
        MTLog("====Test FileManager End====")
        
        //////////////////////////////////////
        //test PullToRefresh
         MTLog("====Test PullToRefresh ====")
        let tbFrame = CGRectMake(0, 200, CGFloat(screenWidth), CGFloat(screenHeight) - 200)
        tableView = UITableView.init(frame: tbFrame)
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier:"Cell")
        tableView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(tableView)
        setupPullToRefresh()
        //end
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(true)
        MTLog("调用指纹验证")
        //let localAutVC :LocalAutViewController = LocalAutViewController()
        //self.presentViewController(localAutVC, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

private extension ViewController {
    
    func setupPullToRefresh () {
        tableView.addPullToRefresh(PullToRefresh()) { [weak self] in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self?.dataSourceCount = PageSize
                self?.tableView.endRefreshing(at: .Top)
            }
        }
        
        tableView.addPullToRefresh(PullToRefresh(position: .Bottom)) { [weak self] in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self?.dataSourceCount += PageSize
                self?.tableView.reloadData()
                self?.tableView.endRefreshing(at: .Bottom)
            }
        }
    }
}

extension ViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}


