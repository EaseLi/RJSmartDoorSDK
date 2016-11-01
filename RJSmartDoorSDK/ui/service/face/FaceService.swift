//
//  FaceService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/4.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class FaceService{
    
    
    /**
     第三方-第三方控制器-获取七牛刷脸令牌-HTTPS
     
     
     - parameter completion: <#completion description#>
     */
    public static func faceUploadToken(completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.FACE_UPLOAD_TOKEN
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,"household_token":household_token,"apply_time":apply_time,"code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    /// 人脸列表
    ///
    /// - parameter completion: <#completion description#>
    public static func faceList(completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.FACE_LIST
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,"household_token":household_token,"apply_time":apply_time,"code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    /// 人脸验证
    ///
    /// - parameter completion: <#completion description#>
    public static func faceRecognitionToken(completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.FACE_RECOGNITION_TOKEN
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,"household_token":household_token,"apply_time":apply_time,"code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    /// 脸部识别控制器-删除人脸
    ///
    /// - parameter person_id:  <#person_id description#>
    /// - parameter face_id:    <#face_id description#>
    /// - parameter completion: <#completion description#>
    public static func faceRemove(person_id:String,face_id:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.FACE_REMOVE
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+household_token+String(household_id)+person_id, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "person_id":person_id,
                                            "face_id":face_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    public static func faceModify(person_id:String,face_id:String,completion:(NSMutableDictionary) -> Void){
        
        let url=AppContant.BASE_URL+AppContant.FACE_MODIFY
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+face_id+household_token+String(household_id), salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "person_id":person_id,
                                            "face_id":face_id,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
    }
    
    
    
    
}
