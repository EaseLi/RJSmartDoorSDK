//
//	CircularDetail.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CircularDetail{
    
    var context : String!
    var publishers : String!
    var title : String!
    var upTime : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        context = dictionary["context"] as? String
        publishers = dictionary["publishers"] as? String
        title = dictionary["title"] as? String
        upTime = dictionary["up_time"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if context != nil{
            dictionary["context"] = context
        }
        if publishers != nil{
            dictionary["publishers"] = publishers
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