//
//  InfoTipViewController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/7.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class InfoTipViewController: BaseView {
    
    var dict =  NSDictionary()
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var infoTitle: UILabel!
    
    @IBOutlet weak var infoText: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log.debug(dict)
        
        self.title = dict["pageTitle"] as? String
        icon.image = dict["icon"] as? UIImage
        infoText.text = dict["text"] as? String
        infoTitle.text = dict["title"] as? String
        button.setTitle(dict["buttonTitle"] as? String, forState: .Normal)
        //        button.addGestureRecognizer((dict["gestureRecognizer"] as? UIGestureRecognizer)!)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func BtnClick(sender: AnyObject) {
        
        switch dict["type"] as! String {
        case AppContant.INFO_TIP_SETPHONE_CONFIRM:
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.SET_NOTIFY_PHONE.STOTY_BOARD, identifier: VCIdentify.SET_NOTIFY_PHONE.IDENTIFIER, title: VCIdentify.SET_NOTIFY_PHONE.TITLE)
        case AppContant.INFO_TIP_SETPHONE_SUCCESS:
            VCRedirect.GLOBAL_MAIN(self, title: "")
        case AppContant.INFO_TIP_FACE_SUCCESS:
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.FACE_MANAGER.STOTY_BOARD, identifier: VCIdentify.FACE_MANAGER.IDENTIFIER, title: VCIdentify.FACE_MANAGER.TITLE)
            
        case AppContant.INFO_TIP_SETPASSWD_SUCCESS:
            VCRedirect.COMMOM_REDIRECT(self, storyboardId: VCIdentify.USER_LOGIN.STOTY_BOARD, identifier: VCIdentify.USER_LOGIN.IDENTIFIER, title: VCIdentify.USER_LOGIN.TITLE)
            
        case AppContant.INFO_TIP_BINDROOM_FAIL:
            VCRedirect.COMMOM_REDIRECT(self, storyboardId:  VCIdentify.USER_LOAD_PROPERTY.STOTY_BOARD, identifier:  VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER, title: "开通门禁")
            
        case AppContant.INFO_TIP_FACE_CONFIRM,AppContant.INFO_TIP_FACE_RESET:
            VCRedirect.FACE_TAKE(self, title: "人脸识别", mode: 0)
            
        default:
            log.debug("选择错误")
        }
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if(!((dict["type"] as! String) == AppContant.INFO_TIP_BINDROOM_FAIL)){
            super.clearViewStack()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    
}
