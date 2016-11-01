//
//	RecordModel.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct RecordModel{
    
    var content : String!
    var imageUrl : String!
    var title : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        content = dictionary["content"] as? String
        imageUrl = dictionary["image_url"] as? String
        title = dictionary["title"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if content != nil{
            dictionary["content"] = content
        }
        if imageUrl != nil{
            dictionary["image_url"] = imageUrl
        }
        if title != nil{
            dictionary["title"] = title
        }
        return dictionary
    }
    
}