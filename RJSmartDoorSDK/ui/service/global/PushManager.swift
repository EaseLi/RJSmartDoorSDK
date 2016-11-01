//
//  PushManager.swift
//  RJSmartDoor
//
//  Created by Ruijia on 2016/10/24.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PushManager{
    
    static let quque = Queue()
    static var working = false
    
    static func enqueque(object:AnyObject){
        quque.enqueue(object)
    }
    
    
    static func run(){
        if working{
            return
        }
        while !quque.isEmpty() {
            let data = quque.dequeue() as! NSMutableDictionary
            //多条推送是否加间隔？
            self.consume(data)
        }
        
        working = !working
        
    }
    

    
    static func consume(data:NSMutableDictionary){
        if let action = data["action"] as? String{
            switch action {
            case AppContant.APNS_NOTIFY_ACT_OPEN_DOOR_RESULT:
                Notify.toast("门已开", type: AppContant.TOAST_SUCCESS)
            case AppContant.APNS_NOTIFY_OPEN_DOOR:
                var dict=Dictionary<String,AnyObject>()
                dict["apply_time"] = data["apply_time"] as! String
                if DateUtils.checkTimeWithSecond(data["apply_time"] as! String, interval: 45){
                    return
                }
                dict["door_ip_address"] = data["door_ip_address"] as! String
                dict["image_url"] = data["image_url"] as! String
                dict["door_name"] = data["door_name"] as! String
                dict["call_info"] = data["call_info"] as! String
                dict["door_net_ease_account"] = data["door_net_ease_account"] as! String
                dict["door_id"] = data["door_id"] as! String
                dict["transaction_no"] = data["transaction_no"] as! String
                
                NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_RING, object: dict)
                
            case AppContant.APNS_NOTIFY_OPEN_DOOR_INTERUPT:
                var dict=Dictionary<String,AnyObject>()
                dict["action"] = data["action"] as! String
                if data["notify_message"] as! String=="1"{
                    dict["msg"] = data["door_name"] as! String+"开门超时"
                }else{
                    dict["msg"] = data["door_name"] as! String+"开门已被取消"
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_OPEN_DOOR, object: dict)
                
            case AppContant.APNS_NOTIFY_OPEN_DOOR_RESULT:
                if data["notify_message"] as! String=="1"{
                    Notify.toast("开门成功", type: AppContant.TOAST_SUCCESS)
                    
                }else{
                    Notify.toast("开门失败", type: AppContant.TOAST_WARN)
                }
            case AppContant.APNS_NOTIFY_OTHER_OPEN_DOOR_RESULT:
                Notify.toast("其他成员已响应", type: AppContant.TOAST_SUCCESS)
                NotificationService.defaultNotice(AppContant.NOTIFY_OTHER_OPEN_DOOR_RESPONSE, msg: nil)
            case AppContant.APNS_NOTIFY_LOGIC:
                
                switch data["notify_message"] as! String {
                case "1"://住户管理同意授权
                    Notify.toast(data["notify_content"] as! String, type: AppContant.TOAST_WARN)
                    NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_AUTHORITY_AGREE, object: nil)
                case "2"://2住户管理拒绝授权
                    let alertView = UIAlertView()
                    alertView.title="系统提示"
                    alertView.message="授权新成员不通过，请咨询物业"
                    alertView.addButtonWithTitle("确定")
                    alertView.delegate =  self
                    alertView.cancelButtonIndex=0
                    alertView.show()
                //                    NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_AUTHORITY_REFUSE, object: nil)
                case "8"://8广告有更新
                    NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_AD_DATA_UPDATE, object: nil)
                case "9","10"://令牌发生改变 账号已在别处登录
                    NSNotificationCenter.defaultCenter().postNotificationName(AppContant.NOTIFY_LOGIN_OUTTIME, object: nil)
                    
                default:
                    log.error("默认处理")
                }
                
            default:
                break
            }
        }else{
            Notify.toast("未适配新协议，下版本修复", type: AppContant.TOAST_WARN)
        }

    }
    
    
}
