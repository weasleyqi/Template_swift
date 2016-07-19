//
//  ViewController.swift
//  Template
//
//  Created by Weasley Qi on 16/7/12.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {

    @IBOutlet weak var testImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testImage.kf_setImageWithURL(NSURL(string: "http://pic29.nipic.com/20130512/12428836_110546647149_2.jpg")!, placeholderImage: UIImage(named: "1.jpg"))
        
        MTLog("Test MTLog")
        
        let str = "test123"
        let str_Md5 = str.md5()
        MTLog(str_Md5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

