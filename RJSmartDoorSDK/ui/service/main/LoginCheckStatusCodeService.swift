//
//  LoginService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/26.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

class LoginCheckStatusCodeService: CheckStatusCodeService {
    
    init(vc:UIViewController){
        self.vc = vc
    }
    
    var vc:UIViewController?
    
    
    override func checkLogicStatus(status: Int, message: String) -> Bool {
      
        var intercept:Bool
        switch status {
        case LogicStatusCode.SUCCESS.CODE:
            intercept=true
            
        case LogicStatusCode.HOME_LOAD_DEFAULT_EMPTY.CODE:
            room=Room()
            intercept=false
            let alertController = AlertController.instance("系统提示", message: "您还未绑定房间，要进行绑定吗?", cancelTitle: "取消", cancelHandler: { (UIAlertAction) in
                    VCRedirect.GLOBAL_MAIN(self.vc!, title: "请绑定")
                }, okTitle: "确定", okHandler: { (UIAlertAction) in
                   VCRedirect.COMMOM_REDIRECT(self.vc!, storyboardId:  VCIdentify.USER_LOAD_PROPERTY.STOTY_BOARD, identifier:  VCIdentify.USER_LOAD_PROPERTY.IDENTIFIER, title: "开通门禁")
                   
            })
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)

        default:
            intercept=false
            Notify.toast(message, type: AppContant.TOAST_WARN)
        }
        
        return intercept
    }
}
