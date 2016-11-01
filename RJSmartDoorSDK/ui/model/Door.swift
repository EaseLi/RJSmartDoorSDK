//
//  Door.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation


struct Door{
    
    var doorId : Int!
    var doorName : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        doorId = dictionary["door_id"] as? Int
        doorName = dictionary["door_name"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if doorId != nil{
            dictionary["door_id"] = doorId
        }
        if doorName != nil{
            dictionary["door_name"] = doorName
        }
        return dictionary
    }
    
}