//
//	Member.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Member{
    
    var authorityStatus : String!
    var householdId : Int!
    var householdName : String!
    var householdType : String!
    var phone : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        authorityStatus = dictionary["authority_status"] as? String
        householdId = dictionary["household_id"] as? Int
        householdName = dictionary["household_name"] as? String
        householdType = dictionary["household_type"] as? String
        phone = dictionary["phone"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if authorityStatus != nil{
            dictionary["authority_status"] = authorityStatus
        }
        if householdId != nil{
            dictionary["household_id"] = householdId
        }
        if householdName != nil{
            dictionary["household_name"] = householdName
        }
        if householdType != nil{
            dictionary["household_type"] = householdType
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        return dictionary
    }
    
}