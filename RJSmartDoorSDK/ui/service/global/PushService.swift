//
//  PushService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 2016/10/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class PushService{
    
    static let checkStatusCodeService = SimpleCheckStatusCodeService.getInstance()
    
    /// 存储管理-存储控制器-加载列表消息-HTTPS
    public static func msgList(msg_type:String,target_name:String,last_update_time:String,effective_duration:Int,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.PUSH_LIST
        
        let terminal_type = "ios"
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+last_update_time, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject] =  ["terminal_type":terminal_type,
                                            "msg_type":msg_type,
                                            "target_name":target_name,
                                            "last_update_time":last_update_time,
                                            "effective_duration":effective_duration,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
        
    }
    
    ///存储管理-存储控制器-加载一条消息-HTTPS
    ///
    /// - parameter completion: <#completion description#>
    public static func msgDetail(msg_id:String,target_name:String,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.PUSH_DETAIL
        let msg_id = msg_id
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+msg_id+target_name, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["msg_id":msg_id,"target_name":target_name,"apply_time":apply_time,"code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
        
    }
    
    
    public static func getSingle(msg_id:String){
        var target_name = ""
        if DataUtils.household_id != 0{
            target_name = DataUtils.device_token + ":" + String(DataUtils.household_id)
        }
        
        self.msgDetail(msg_id, target_name: target_name) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            PushManager.enqueque(result["response"]!["content"]!!["list"]!![0])

        }
    }
    
    public static func getList(){
      
        var target_name = ""
        if DataUtils.household_id != 0{
            target_name = DataUtils.device_token + ":" + String(DataUtils.household_id)
        }
        
        let last_update_time = DataUtils.last_update_time
       
        self.msgList("", target_name: target_name, last_update_time: last_update_time, effective_duration: -1) { (result) in
            if !self.checkResponseStatus(result){
                return
            }
            
            if let list = result["response"]!["content"]!!["list"] as? [NSMutableDictionary]{
                for dic in list{
                    let time = dic["last_update_time"] as! String
                    if DateUtils.compareTime(time, timeStampTwo: last_update_time) == 1{
                        DataUtils.setLastUpdateTime("last_update_time")
                    }
                    PushManager.enqueque(dic)
                }
            }

            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        }
    }
    
    public static func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        return checkStatusCodeService.checkResponseStatus(response)
        
    }

    
    
}
