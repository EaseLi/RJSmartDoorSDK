//
//  Room.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
struct Room{
    
    var communityId : Int!
    var communityName : String!
    var householdType : String!
    var list : [Door]!
    var propertyId : Int!
    var roomModel : String!
    var roomNodeId : Int!
    var shieldingVisitors : String!
    var timeoutCallNumber : String!
    
    init(){
        self.communityId = 0
        self.communityName = ""
        self.householdType = ""
        self.list = []
        self.propertyId = 0
        self.roomModel = ""
        self.roomNodeId = -1
        self.shieldingVisitors = ""
        self.timeoutCallNumber = ""
        
    }
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        communityId = dictionary["community_id"] as? Int
        communityName = dictionary["community_name"] as? String
        householdType = dictionary["household_type"] as? String
        list = [Door]()
        if let listArray = dictionary["list"] as? [NSDictionary]{
            for dic in listArray{
                let value = Door(fromDictionary: dic)
                list.append(value)
            }
        }
        propertyId = dictionary["property_id"] as? Int
        roomModel = dictionary["room_model"] as? String
        roomNodeId = dictionary["room_node_id"] as? Int
        shieldingVisitors = dictionary["shielding_visitors"] as? String
        timeoutCallNumber = dictionary["timeout_call_number"] as? String
    }
    
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if communityId != nil{
            dictionary["community_id"] = communityId
        }
        if communityName != nil{
            dictionary["community_name"] = communityName
        }
        if householdType != nil{
            dictionary["household_type"] = householdType
        }
        if list != nil{
            var dictionaryElements = [NSDictionary]()
            for listElement in list {
                dictionaryElements.append(listElement.toDictionary())
            }
            dictionary["list"] = dictionaryElements
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if roomModel != nil{
            dictionary["room_model"] = roomModel
        }
        if roomNodeId != nil{
            dictionary["room_node_id"] = roomNodeId
        }
        if shieldingVisitors != nil{
            dictionary["shielding_visitors"] = shieldingVisitors
        }
        if timeoutCallNumber != nil{
            dictionary["timeout_call_number"] = timeoutCallNumber
        }
        return dictionary
    }
    
}