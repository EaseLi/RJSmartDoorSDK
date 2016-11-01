//
//  HomeService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
public class HomeService{
    
    /**
     加载默认首页
     
     - parameter household_id:    必填;Long;住户编号
     - parameter household_token: 必填;String;住户令牌
     - parameter room_node_id:    必填;Long;房间节点编号,获取全部填-1
     - parameter result:          NSMutableDictionary
     */
    public static func loadDefaultHome(household_id:Int,household_token:String,room_node_id:Int,result:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.HOME_LOAD_DEFAULT_HOME
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "room_node_id":room_node_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            log.debug("callback==>\(response)")
            
            result(response)
            
        })
    }
    
    /**
     开门控制器-主动开门
     
     - parameter household_id:    必填;Long;住户编号
     - parameter household_token: 必填;String;住户令牌
     - parameter transaction_no:  流水号
     - parameter door_id:         门id
     - parameter completion:      回调
     */
    public static func openDoor(household_id:Int,household_token:String,transaction_no:String,door_id:Int,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.HOME_OPEN_DOOR
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token+String(door_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "transaction_no":transaction_no,
                                            "door_id":door_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    /**
     睿家-开门控制器-响应访客开门
     
     - parameter transaction_no: <#transaction_no description#>
     - parameter door_id:        <#door_id description#>
     - parameter completion:     <#completion description#>
     */
    public static func respondVisit(transaction_no:String,door_id:Int,result:String,open_type:String,call_info:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.HOME_RESPONSE_VISIT
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(door_id)+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "transaction_no":transaction_no,
                                            "door_id":door_id,
                                            "result":result,
                                            "open_type":open_type,
                                            "call_info":call_info,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    /**
     睿家-呼叫设置控制器-设置免扰模式
     
     - parameter room_node_id:       <#room_node_id description#>
     - parameter shielding_visitors: <#shielding_visitors description#>
     */
    public static func setupShielding(room_node_id:Int,shielding_visitors:String,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.HOME_SETUP_SHIELDING
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+shielding_visitors+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "room_node_id":room_node_id,
                                            "shielding_visitors":shielding_visitors,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    /**
     睿家-授权控制器-修改房间模式
     
     - parameter node_id:    <#node_id description#>
     - parameter room_model: <#room_model description#>
     - parameter completion: <#completion description#>
     */
    public static func authorizationRoomModel(node_id:Int,room_model:String,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.HOME_AUTHOR_ROOM_MODEL
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+String(node_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "node_id":node_id,
                                            "room_model":room_model,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
}
