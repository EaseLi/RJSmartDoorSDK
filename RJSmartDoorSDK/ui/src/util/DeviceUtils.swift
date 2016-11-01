//
//  DeviceUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import ReachabilitySwift
import AVFoundation

public class DeviceUtils{


    /**
     获取网络类型
     
     - returns: <#return value description#>
     */
    public static func getNetworkType()->String{
        var network_type=""
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return ""
        }
        
        //判断连接类型
        if reachability.isReachable(){
            if reachability.isReachableViaWiFi() {
                network_type="wifi"
            } else {
                network_type="cellular"
            }
        }
        
        return network_type
    }
    
    /**
     获取系统版本
     
     - returns: <#return value description#>
     */
    public static func getOSVersion()->String{
       return UIDevice.currentDevice().systemVersion
    }
    
    /**
     获取软件版本号
     
     - returns: <#return value description#>
     */
    public static func getAppVersion()->String{
        let infoDict:NSDictionary = NSBundle.mainBundle().infoDictionary!
        
        let app_version = infoDict.objectForKey("CFBundleShortVersionString") as! String
        return app_version
    }
    
    public static func getDeviceModelName()->String{
        return UIDevice.currentDevice().modelName
    }
    
    /**
     判断相机权限
     
     - returns: 有权限返回true，没权限返回false
     */
    public static func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        if(authStatus == AVAuthorizationStatus.Denied || authStatus == AVAuthorizationStatus.Restricted) {
            return false
        }else {
            return true
        }
        
        
    }
}