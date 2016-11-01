//
//  PushManagerDelegate.swift
//  RJSmartDoor
//
//  Created by Ruijia on 2016/10/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

protocol PushManagerDelegate{
    
    func msgListmsgList(msg_type:String,target_name:String,last_update_time:String,effective_duration:String,completion:(NSMutableDictionary) -> Void)

    func msgDetail(msg_id:String,target_name:String,completion:(NSMutableDictionary) -> Void)
    
}
