//
//  FaceManager.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class FaceManager: BaseView {
    
    @IBOutlet weak var managerBtn: UIView!
    @IBOutlet weak var checkBtn: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerBtn.addOnClickListener(self, action: #selector(FaceManager.toFaceList))
        checkBtn.addOnClickListener(self, action: #selector(FaceManager.toFaceCheck))
    }
    
    func toFaceList(){
        VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_LIST.STOTY_BOARD, identifier: VCIdentify.FACE_LIST.IDENTIFIER, title: VCIdentify.FACE_LIST.TITLE)
    
    }
    
    func toFaceCheck(){
         VCRedirect.FACE_TAKE(self, title: "正在验证", mode: 1)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        super.clearViewStack()
    }

}
