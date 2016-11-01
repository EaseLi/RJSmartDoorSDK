//
//  AccountService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class AccountService{
    
    public static func logout(){
        NSUserDefaultsUtils.remove("isLogin")
        NSUserDefaultsUtils.remove("room")
        room = Room()
        NotificationService.defaultNotice(AppContant.NOTIFY_PAGE_REDIRECT, msg: VCIdentify.USER_LOGIN.IDENTIFIER)
        NotificationService.defaultNotice(AppContant.NOTIFY_LOGIN_OUT, msg: nil)
        
        
    }
    
    
}



