//
//  BindRoomCheckStatusCodeService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/26.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class BindRoomCheckStatusCodeService: CheckStatusCodeService {
    
    override func checkLogicStatus(status: Int, message: String) -> Bool {
        
        var intercept:Bool
        switch status {
        case LogicStatusCode.SUCCESS.CODE:
            intercept=true
        default:
            intercept=false
        }
        if !intercept{
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_BIND_ROOM_PAGE_REDIRECT, object: message)
            
        }
        return intercept
        
        
        
    }
}
