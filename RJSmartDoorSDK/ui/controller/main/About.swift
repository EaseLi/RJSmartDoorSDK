//
//  About.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/18.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class About: BaseView  {

    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var copyright: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        version.text = "版本 \(DeviceUtils.getAppVersion())"
        copyright.text = AppContant.COPYRIGHT
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
