//
//  CircularService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class CircularService{
    
    /**
     加载公告列表
     
     - parameter offset:     <#offset description#>
     - parameter limit:      <#limit description#>
     - parameter completion: <#completion description#>
     */
    public static func loadList(offset:Int ,limit:Int,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.CIRCULAR_LIST
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "circular_type":"1",
                                            "last_update_time":"",
                                            "offset":offset,
                                            "limit":limit,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    /**
     公告控制器-修改公告已读状态-HTTPS
     
     - parameter circular_id: <#circular_id description#>
     - parameter completion:  <#completion description#>
     */
    public static func read(circular_id:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.CIRCULAR_READ
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+circular_id+String(household_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "circular_id":circular_id,
                                            "read_status":"1",
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    /**
     公告控制器-加载公告详细信息-HTTPS
     
     - parameter circular_id: <#circular_id description#>
     - parameter completion:  <#completion description#>
     */
    public static func detail(circular_id:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.CIRCULAR_DETAIL
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+circular_id+String(household_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "circular_id":circular_id,
                                            "read_status":"1",
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    
    
    
}