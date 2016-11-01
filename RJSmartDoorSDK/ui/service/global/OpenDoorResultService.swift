//
//  OpenDoorResultService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/27.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class OpenDoorResultService {
    
    var checkStatusCodeService = CheckStatusCodeService.getInstance()
    var transaction_no:String?
    var thread:NSThread?
    var interval:NSTimeInterval?
    var count:UInt32 = 0{
        didSet{
            switch count {
            case 1:
                interval = 1.0
            case 2:
                interval = 2.0
            case 3:
                interval = 3.0
            case 4:
                interval = 4.0
            case 5:
                interval = 5.0
            default:
                break
            }
            
        }
    }
    
    //    static var timer:NSTimer{
    //        return  NSTimer.scheduledTimerWithTimeInterval(10*60, target: self, selector: #selector(AdService.checkADStatus), userInfo: nil, repeats: true)
    //    }
    
    
    func getOpenDoor(transaction_no:String,completion:(NSMutableDictionary) -> Void) {
        let url=AppContant.BASE_URL+AppContant.HOME_OPEN_DOOR_RESULT
        
        let household_id = DataUtils.household_id
        let household_token = DataUtils.household_token
        let transaction_no = transaction_no
        
        let apply_time=DateUtils.getTimeStamp()
        let code = SecrecyUtils.sha256(apply_time+String(household_id)+transaction_no+household_token, salt: AppContant.INTERFACE_SALT)
        let requestData:[String:AnyObject]=["household_id":household_id,
                                            "household_token":household_token,
                                            "transaction_no":transaction_no,
                                            "apply_time":apply_time,
                                            "code":code]
        
        HttpService.post(url, requestData: requestData, callback: {(response:NSMutableDictionary)->Void in
            completion(response)
            
        })
        
    }
    
    
    func run(transaction_no:String){
        self.transaction_no = transaction_no
        count = 0
        thread = NSThread.init(target: self, selector:#selector(OpenDoorResultService.getResult), object: transaction_no)
        
        thread?.start()
        
    }
    
    @objc func getResult(current_transaction_no:String){
        log.debug("transaction_no:\(transaction_no)==>\(count)::: current_transaction_no:\(current_transaction_no)")
        
        if(self.transaction_no != current_transaction_no){
            log.debug("已经失效")
            return
        }
        if count==5 {
            dispatch_async(dispatch_get_main_queue()) {
                Notify.toast("开门超时，请重试", type: AppContant.TOAST_SUCCESS)
            }
            return
        }
      
        count += 1
        log.debug("begin sleep")
        
        let nonBlockingQueue: dispatch_queue_t = dispatch_queue_create("nonBlockingQueue", DISPATCH_QUEUE_CONCURRENT)
        dispatch_async(nonBlockingQueue) {
            NSThread.sleepForTimeInterval(self.interval!)
            dispatch_async(dispatch_get_main_queue(), {
                log.debug("end sleep")
                self.getOpenDoor(self.transaction_no!) { (result) in
                    if(!self.checkResponseStatus(result)){
                        self.getResult(current_transaction_no)
                        return
                    }
                    
                    if let dict = result["response"]!["content"] as? NSDictionary where dict.count>0 {
                        if ((dict["notify_message"] as! String) == "1"){
                            dispatch_async(dispatch_get_main_queue()) {
                                Notify.toast("开门成功", type: AppContant.TOAST_SUCCESS)
                            }
                            
                        }else{
                            dispatch_async(dispatch_get_main_queue()) {
                                Notify.toast("开门失败", type: AppContant.TOAST_SUCCESS)
                            }
                            
                        }
                    }else{
                        self.getResult(current_transaction_no)
                    }
                    
                }

            })
        }
        
//        NSThread.sleepForTimeInterval(5)
//        sleep(count)
//        NSThread.sleepForTimeInterval(interval)
        
        
    }
    
    func checkResponseStatus(response:NSMutableDictionary) -> Bool {
        return checkStatusCodeService.checkResponseStatus(response)
    }
    
    
}
