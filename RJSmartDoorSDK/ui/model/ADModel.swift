//
//	ADModel.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ADModel{
    
    var advertId : Int!
    var advertType : Int!
    var backLinks : String!
    var context : String!
    var contextType : String!
    var downTime : String!
    var playTime : Int!
    var title : String!
    var upTime : String!
    var isShow = true
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        advertId = dictionary["advert_id"] as? Int
        advertType = dictionary["advert_type"] as? Int
        backLinks = dictionary["back_links"] as? String
        context = dictionary["context"] as? String
        contextType = dictionary["context_type"] as? String
        downTime = dictionary["down_time"] as? String
        playTime = dictionary["play_time"] as? Int
        title = dictionary["title"] as? String
        upTime = dictionary["up_time"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if advertId != nil{
            dictionary["advert_id"] = advertId
        }
        if advertType != nil{
            dictionary["advert_type"] = advertType
        }
        if backLinks != nil{
            dictionary["back_links"] = backLinks
        }
        if context != nil{
            dictionary["context"] = context
        }
        if contextType != nil{
            dictionary["context_type"] = contextType
        }
        if downTime != nil{
            dictionary["down_time"] = downTime
        }
        if playTime != nil{
            dictionary["play_time"] = playTime
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