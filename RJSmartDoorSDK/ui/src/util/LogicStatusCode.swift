//
//  LogicStatusCode.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/23.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

struct LogicStatusCode {
    
    init(CODE:Int, MESSAGE:String) {
        self.CODE = CODE
        self.MESSAGE = MESSAGE
    }
    
    let CODE:Int
    let MESSAGE:String
    
    static let SUCCESS=LogicStatusCode(CODE: 0, MESSAGE: "成功")
    static let ACCOUNT_INVALID=LogicStatusCode(CODE: 20001, MESSAGE: "非法用户")
    static let REQUEST_INVALID=LogicStatusCode(CODE: 20002, MESSAGE: "非法请求")
    static let CALL_NUMBER_NOT_EXIST=LogicStatusCode(CODE: 20003, MESSAGE: "呼叫号码不存在")
    static let GET_PHONE_CONFIGURATION_ABNORMAL=LogicStatusCode(CODE: 30001, MESSAGE: "获取手机配置信息异常")
    static let GET_DOOR_CONFIGURATION_ABNORMAL=LogicStatusCode(CODE: 31001, MESSAGE: "获取门口机配置信息异常")
    static let TOKEN_INVALID=LogicStatusCode(CODE: 31002, MESSAGE: "无效令牌")
    static let TOKEN_OUTDATE=LogicStatusCode(CODE: 700, MESSAGE: "登录已过期，请重新登录")
    static let UNKNOWN=LogicStatusCode(CODE: 40001, MESSAGE: "未知错误")
    
    
    static let HOME_LOAD_DEFAULT_EMPTY = LogicStatusCode(CODE: 230001, MESSAGE: "房间不存在")
    
    
    
    
    
}
