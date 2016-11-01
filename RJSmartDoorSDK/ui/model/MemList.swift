//
//	MemList.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MemList{

	var member : [Member]!

    init(){
    }

	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		member = [Member]()
		if let memberArray = dictionary["member"] as? [NSDictionary]{
			for dic in memberArray{
				let value = Member(fromDictionary: dic)
				member.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if member != nil{
			var dictionaryElements = [NSDictionary]()
			for memberElement in member {
				dictionaryElements.append(memberElement.toDictionary())
			}
			dictionary["member"] = dictionaryElements
		}
		return dictionary
	}

}