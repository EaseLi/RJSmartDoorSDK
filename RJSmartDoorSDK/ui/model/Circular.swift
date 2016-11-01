//
//	Circular.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Circular{
    
    var circularId : Int!
    var contextType : String!
    var readStatus : String!
    var title : String!
    var upTime : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        circularId = dictionary["circular_id"] as? Int
        contextType = dictionary["context_type"] as? String
        readStatus = dictionary["read_status"] as? String
        title = dictionary["title"] as? String
        upTime = dictionary["up_time"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if circularId != nil{
            dictionary["circular_id"] = circularId
        }
        if contextType != nil{
            dictionary["context_type"] = contextType
        }
        if readStatus != nil{
            dictionary["read_status"] = readStatus
        }
        if title != nil{
            dictionary["title"] = title
        }
        if upTime != nil{
            dictionary["up_time"] = upTime
        }
        return dictionary
    }
    
}