//
//  CacheService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class CacheService:NSObject {
    //单例
    override private init() {}
    static let sharedInstance = CacheService()
    
    
    /// 初始化容器
    var dict = Dictionary<String,AnyObject>()
    
    
    /**
     增、改
     - parameter key:   <#key description#>
     - parameter value: <#value description#>
     */
    func set(key:String, value:AnyObject?){
        
        dict[key] = value
    }
    
    
    /**
     根据key查询
     
     - parameter key: <#key description#>
     
     - returns: <#return value description#>
     */
    func get(key:String)->AnyObject?{
        
        return dict[key]
        
    }
    
    
    
    /**
     根据key删除
     
     - parameter key: <#key description#>
     */
    func remove(key:String){
        
        dict.removeValueForKey(key)
    }
    
    /**
     清空数据
     */
    func clear(){
        
        dict.removeAll()
    }
    
}
