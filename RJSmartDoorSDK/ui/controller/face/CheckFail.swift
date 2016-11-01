//
//  CheckFail.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class CheckFail: BaseView {
    
    
    @IBOutlet weak var tip: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
//        CacheService.sharedInstance.remove("ViewController.CheckFace")
    }
    
    @IBAction func checkAgain(sender: AnyObject) {
        let vc =  CacheService.sharedInstance.get("ViewController.CheckFace") as! TakeFace
        self.navigationController?.popToViewController(vc, animated: true)
        
    }
    
//    @IBAction func takeAgain(sender: AnyObject) {
//        if let vc = CacheService.sharedInstance.get("ViewController.TakeFace") as? TakeFace{
//            self.navigationController?.popToViewController(vc, animated: true)
//        }else{
//            VCRedirect.FACE_TAKE(self, title: "人脸识别", mode: 0)
//        }
//        
//    }
    
    @IBAction func cancel(sender: AnyObject) {
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_MANAGER.STOTY_BOARD, identifier: VCIdentify.FACE_MANAGER.IDENTIFIER, title: VCIdentify.FACE_MANAGER.TITLE)
    }
}
