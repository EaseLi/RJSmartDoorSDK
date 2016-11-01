//
//  Feedback.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/23.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class Feedback: BaseView {

 
    @IBOutlet weak var phoneContain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneContain.addOnClickListener(self, action: #selector(Feedback.toCall))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toCall(){
        let phoneNum = NSURL(string: "tel://4009110110")
        UIApplication.sharedApplication().openURL(phoneNum!)
    }
    
    
}
