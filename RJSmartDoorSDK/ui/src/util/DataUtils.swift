//
//  DataUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/15.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
public class DataUtils{
    
    static var mobile:String{
        return NSUserDefaultsUtils.getString("mobile")
    }
    
    static var name:String{
        return NSUserDefaultsUtils.getString("name")
    }
    
    static var avatar:String{
        return NSUserDefaultsUtils.getString("avatar_url")
        
    }
    
    static var household_id:Int{
        return NSUserDefaultsUtils.getInt("household_id")
    }
    
    static var household_token:String{
        return NSUserDefaultsUtils.getString("household_token")
    }
    
    static var device_token:String{
        return NSUserDefaultsUtils.getString("device_token")
    }
    
    static var last_update_time:String{
        return NSUserDefaultsUtils.getString("last_update_time")
    }
    
    
    public static func setDeviceToken(token:NSString){
        NSUserDefaultsUtils.setValue("device_token", value: token as String)
        
    }
    
    public static func setAvatar(imgurl:String){
        NSUserDefaultsUtils.setValue("avatar_url", value: imgurl)
    }
    
    public static func setName(name:String){
        NSUserDefaultsUtils.setValue("name", value: name)
    }
    
    public static func setLastUpdateTime(last_update_time:String){
        NSUserDefaultsUtils.setValue("last_update_time", value: last_update_time)
    }
    
    
    
}
