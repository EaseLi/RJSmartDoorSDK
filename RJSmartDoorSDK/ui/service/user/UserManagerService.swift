//
//  UserManagerService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class UserManagerService{
    
    /**
     成员列表
     
     - parameter household_id:    住户编号
     - parameter household_token: 住户令牌
     - parameter node_id:         房间节点id
     - parameter completion:      回调
     */
    public static func memberList(household_id:Int,household_token:String,node_id:Int,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.MEMBER_LIST
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token+String(node_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "node_id":node_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    public static func memberAdd(household_id:Int,household_token:String,node_id:Int,member_phone:String,member_household_type:String,completion:(NSMutableDictionary) -> Void){
        
        
        let url=AppContant.BASE_URL+AppContant.MEMBER_ADD
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token+String(node_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "node_id":node_id,
                                            "member_phone":member_phone,
                                            "member_household_type":member_household_type,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    public static func memberRemove(household_id:Int,household_token:String,member_household_id:Int,member_node_id:Int,member_household_type:String,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.MEMBER_REMOVE
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(member_node_id)+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "member_household_id":member_household_id,
                                            "member_node_id":member_node_id,
                                            "member_household_type":member_household_type,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
}
