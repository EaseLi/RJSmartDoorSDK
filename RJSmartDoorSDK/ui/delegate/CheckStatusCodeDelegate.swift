//
//  CheckStatusCodeDelegate.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

protocol CheckStatusCodeDelegate {
    /**
     网络返回码校验
     
     - parameter status: http status
     
     - returns: 校验结果
     */
    func checkHttpStatus(status:Int) -> Bool
    
    func checkLogicStatus(status:Int,message:String) -> Bool
    
    func checkResponseStatus(response:NSMutableDictionary) -> Bool
}
