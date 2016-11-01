//
//  UserService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
public class UserService{
    
    
    public static func setPassWd(password:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.USER_COMPLETE_INFO
        
        let household_id = DataUtils.household_id
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,"password":password,"apply_time":apply_time,"code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    /**
     加载默认首页
     
     - parameter household_id:    必填;Long;住户编号
     - parameter household_token: 必填;String;住户令牌
     - parameter room_node_id:    必填;Long;房间节点编号,获取全部填-1
     - parameter result:          NSMutableDictionary
     */
    public static func loadAccountLogin(account:String,passwd:String,result:(NSMutableDictionary) -> Void){
        
        
        
        let url=AppContant.BASE_URL+AppContant.USER_LOGIN
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+account+passwd, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["account":account,
                                            "password":passwd,
                                            "phone_type":"IOS",
                                            "firmware_version":DeviceUtils.getOSVersion(),
                                            "app_version":DeviceUtils.getAppVersion(),
                                            "network_type":DeviceUtils.getNetworkType(),
                                            "hardware_version":DeviceUtils.getDeviceModelName(),
                                            "ext1":DataUtils.device_token, //扩展字段，IOS填APPLE令牌
            "ext2":AppContant.PUSH_TOKEN, //扩展字段，IOS填APPLE令牌
            "apply_time":apply_time,
            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            result(response)
            
        })
    }
    
    /**
     获取物业列表
     
     - parameter household_id:    住户编号
     - parameter household_token: 住户令牌
     - parameter result:          结果回调
     */
    public static func loadPropertyList(household_id:Int,household_token:String,result:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.USER_LOAD_PROPERTY_LIST
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            result(response)
            
        })
    }
    
    /**
     获取小区列表
     
     - parameter household_id:    住户编号
     - parameter household_token: 住户令牌
     - parameter property_id:     物业id
     - parameter completion:      结果回调
     */
    public static func loadCommunityList(household_id:Int,household_token:String,property_id:Int,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.USER_LOAD_COMMUNITY_LIST
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(property_id)+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "property_id":property_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    /**
     获取节点列表
     
     - parameter household_id:    住户编号
     - parameter household_token: 住户令牌
     - parameter node_id:         节点id
     - parameter completion:      回调
     */
    public static func loadNodeList(household_id:Int,household_token:String,node_id:Int,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.USER_LOAD_NODE_LIST
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(node_id)+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "node_id":node_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    public static func loadRoomList(household_id:Int,household_token:String,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.USER_LOAD_ROOM_LIST
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
        
    }
    
    public static func checkInfomation(household_id:Int,household_token:String,property_id:Int,
                                       community_id:Int,node_id:Int,household_name:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.USER_CHECK_INFOMATION
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token+String(node_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "property_id":property_id,
                                            "community_id":community_id,
                                            "node_id":node_id,
                                            "household_name":household_name,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
        
    }
    
    /**
     呼叫设置控制器-设置电话通知
     
     - parameter household_id:        住户id
     - parameter household_token:     住户令牌
     - parameter room_node_id:        房间id
     - parameter timeout_call_number: 呼叫号码
     - parameter completion:          <#completion description#>
     */
    public static func setNotifyPhone(household_id:Int,household_token:String,room_node_id:Int,timeout_call_number:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.SET_NOTIFY_PHONE
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+String(timeout_call_number)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "room_node_id":room_node_id,
                                            "timeout_call_number":timeout_call_number,
                                            "apply_time":apply_time,
                                            "code":code]
        
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            
            completion(response)
            
        })
    }
    
    /**
     上传头像
     
     - parameter fileName:   <#fileName description#>
     - parameter image:      <#image description#>
     - parameter completion: <#completion description#>
     */
    public static func uploadAvatar(fileName:String,image:UIImage,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.USER_UPLOAD_AVATAR
        
        let household_id =  DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "types":"avatar",
                                            "filenames":fileName,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.multipartUpload(url, requestData: requestData, file: image) { (response) in
             completion(response)
        }
        
    
    }
    
    /**
     修改名称
     
     - parameter household_name: <#household_name description#>
     - parameter completion:     <#completion description#>
     */
    public static func modifyName(household_name:String,completion:(NSMutableDictionary) -> Void){
        let url=AppContant.BASE_URL+AppContant.USER_MODIFY_NAME
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject] =
            ["household_id":household_id,
             "household_token":household_token,
             "household_name":household_name,
             "apply_time":apply_time,
             "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
}
