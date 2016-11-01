//
//  NetEaseService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit
public class NetEaseService{

    
    public static func login(){
        NIMSDK.sharedSDK().registerWithAppID(AppContant.NET_EASE_KEY, cerName: "")
        let net_ease_account = NSUserDefaultsUtils.getString("net_ease_account")
        let net_ease_token = NSUserDefaultsUtils.getString("net_ease_token")
        NIMSDK.sharedSDK().loginManager.login(net_ease_account, token: net_ease_token, completion: {(error) in
            if(error != nil){
                log.debug("NIMSDK.sharedSDK().loginManager.login==>\(error)")
            }else{
                log.debug("NIMSDK.sharedSDK().loginManager.login==>SUCCESS")
            }
            
        })
    }

    
}
