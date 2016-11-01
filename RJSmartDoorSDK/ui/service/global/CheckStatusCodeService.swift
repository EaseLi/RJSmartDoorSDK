//
//  CheckStatusCodeService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class CheckStatusCodeService : CheckStatusCodeDelegate {
    
    //单例
    private static let instance = CheckStatusCodeService()
    
    static func getInstance()->CheckStatusCodeService{
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
        if !intercept{
            Notify.toast("网络不好，请稍后重试", type: AppContant.TOAST_WARN)
        }
        return intercept
    }
    
    func checkLogicStatus(status:Int,message:String) -> Bool {
    
        var intercept:Bool=false
        switch status {
        case LogicStatusCode.SUCCESS.CODE:
            intercept=true
        case LogicStatusCode.TOKEN_OUTDATE.CODE:
            print("")
        default:
            Notify.toast(message, type: AppContant.TOAST_WARN)
        }
        
        return intercept
    }
    
    func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        
        return response.count>0&&checkHttpStatus(response["httpStatus"] as! Int)&&checkLogicStatus(response["response"]!["status"] as! Int,message: response["response"]!["message"] as! String)
    }

    
}
