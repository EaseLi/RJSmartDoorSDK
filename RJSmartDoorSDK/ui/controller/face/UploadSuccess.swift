//
//  UploadSuccess.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/28.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class UploadSuccess: BaseView {
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func checkFace(sender: AnyObject) {
        VCRedirect.FACE_TAKE(self, title: "正在验证", mode: 1)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_MANAGER.STOTY_BOARD, identifier: VCIdentify.FACE_MANAGER.IDENTIFIER, title: VCIdentify.FACE_MANAGER.TITLE)
    }
    
}
