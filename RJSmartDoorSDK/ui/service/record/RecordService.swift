//
//  RecordService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/18.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class RecordService{
    /**
     门禁记录-记录控制器-加载开门记录列表
     
     - parameter room_node_id: 房间id
     
     - parameter offset:       起始位置
     - parameter limit:        获取数据条数
     - parameter completion:   <#completion description#>
     */
    public  static func loadCallList(room_node_id:Int,offset:Int,limit:Int,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.RECORD_LOAD_CALL_LIST
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token+String(room_node_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "room_node_id":room_node_id,
                                            "offset":offset,
                                            "limit":limit,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    
    public static func loadOpenLockList(room_node_id:Int,offset:Int,limit:Int,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.RECORD_LOAD_OPEN_LIST
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+household_token+String(household_id)+String(room_node_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "room_node_id":room_node_id,
                                            "offset":offset,
                                            "limit":limit,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
}