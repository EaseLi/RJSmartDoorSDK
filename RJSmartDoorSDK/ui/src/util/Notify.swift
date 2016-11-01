//
//  Notify.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import JDStatusBarNotification

public class Notify{
    
    public static func toast(msg:String,type:String){
     
        if(!msg.isEmpty){
            log.debug(msg)
            JDStatusBarNotification.showWithStatus(msg,dismissAfter: 2.0,styleName: type)
        }else{
            log.debug(" 服务端返回消息异常 ")
        }
        
    }
}
