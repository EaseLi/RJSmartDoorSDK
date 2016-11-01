//
//  SimpleCheckStatusCodeService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 2016/10/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

class SimpleCheckStatusCodeService : CheckStatusCodeDelegate {
    
    //单例
    private static let instance = SimpleCheckStatusCodeService()
    
    static func getInstance()->SimpleCheckStatusCodeService{
        return instance
    }
    
    func checkHttpStatus(status:Int) -> Bool {
        var intercept:Bool
        switch status {
        case HttpStatusCode.SUCCESS.CODE:
            intercept=true
        default:
            intercept=false
        }
        return intercept
    }
    
    func checkLogicStatus(status:Int,message:String) -> Bool {
        
        var intercept:Bool=false
        switch status {
        case LogicStatusCode.SUCCESS.CODE:
            intercept=true
        case LogicStatusCode.TOKEN_OUTDATE.CODE:
            break
        default:
            break
        }
        
        return intercept
    }
    
    func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        
        return response.count>0&&checkHttpStatus(response["httpStatus"] as! Int)&&checkLogicStatus(response["response"]!["status"] as! Int,message: response["response"]!["message"] as! String)
    }
    
    
}
