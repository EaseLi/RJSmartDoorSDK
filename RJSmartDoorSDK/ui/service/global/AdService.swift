//
//  AdService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/5.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class AdService{
    
    static var checkStatusCodeService = CheckStatusCodeService.getInstance()
    
    static var timer:NSTimer{
        return  NSTimer.scheduledTimerWithTimeInterval(10*60, target: self, selector: #selector(AdService.checkADStatus), userInfo: nil, repeats: true)
    }
    
    
    static func loadList(offset:Int ,limit:Int,completion:(NSMutableDictionary) -> Void) {
        let url=AppContant.BASE_URL+AppContant.AD_LIST
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let property_id =  room.propertyId
        let community_id =  room.communityId
        let advert_type = ""
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+advert_type+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "property_id":property_id,
                                            "community_id":community_id,
                                            "advert_type":advert_type,
                                            "last_update_time":"",
                                            "offset":offset,
                                            "limit":limit,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
        
    }
    
    static func run(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AdService.getADList), name: AppContant.NOTIFY_AD_DATA_UPDATE, object: nil)
        
        if let adArray =  NSUserDefaultsUtils.getObj("adlist"){
            for dic in adArray  as! [NSDictionary]{
                var value = ADModel(fromDictionary: dic)
                
                if(DateUtils.compareWithNow(value.upTime)==1){
                    value.isShow = true
                }
                adlist.append(value)
            }
            
            
        }
        getADList()
        self.timer
        
        
    }
    
    @objc static func getADList(){
        loadList(-1, limit: -1) { (result) in
            if !checkResponseStatus(result){
                //                NSThread.sleepForTimeInterval(60)
                //                getADList()
                return
            }
            
            
            if let adArray = result["response"]!["content"]!!["list"]  as? [NSDictionary]{
                if adArray.count==0{
                    return
                }
                
                NSUserDefaultsUtils.setObject("adlist", value: result["response"]!["content"]!!["list"] as! [NSDictionary])
                adlist.removeAll()
                for dic in adArray{
                    var value = ADModel(fromDictionary: dic)
                    if(DateUtils.compareWithNow(value.upTime)==1){
                        value.isShow = true
                    }
                    adlist.append(value)
                }
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_AD_UPDATE, object: nil)
            
        }
        
    }
    
    
    
    
    @objc static func checkADStatus(){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //这里写需要大量时间的代码
            log.debug("===checkADStatus begin===")
            
            if adlist.count != 0{
                var isUpdate = false
                
                var length = adlist.count
                while(length > 0){
                    let index = length - 1
                    
                    print(index)
                    if(DateUtils.compareWithNow(adlist[index].upTime)==1){
                        if !adlist[index].isShow{
                            adlist[index].isShow = true
                            isUpdate = true
                        }
                    }
                    
                    if (DateUtils.compareWithNow(adlist[index].downTime) == -1){
                        adlist.removeAtIndex(index)
                        isUpdate = true
                    }
                    length -= 1
                }
                
                
                if isUpdate{
                    dispatch_async(dispatch_get_main_queue()){
                        //这里返回主线程，写需要主线程执行的代码
                        NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_AD_UPDATE, object: nil)
                        //这里返回主线程，写需要主线程执行的代码
                        
                    }
                    
                }
            }
            
            log.debug("===checkADStatus end===")
            
            
            
        }
    }
    
    
    static func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        return checkStatusCodeService.checkResponseStatus(response)
    }
    
}
