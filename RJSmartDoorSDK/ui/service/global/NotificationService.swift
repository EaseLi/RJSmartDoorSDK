//
//  NotificationService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class NotificationService{
    
    public static func defaultNotice(target:String,msg:AnyObject?){
        NSNotificationCenter.defaultCenter().postNotificationName(target, object: msg)
    }
}
