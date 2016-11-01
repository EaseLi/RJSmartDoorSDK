//
//  MainMenu.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/17.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

struct MainMenu {
    
    init(title:String,subTitle:String,type:Int,icon:String,masterMenu:Bool,menuId:String){
        self.title = title
        self.subTitle = subTitle
        self.type = type
        self.icon = icon
        self.masterMenu = masterMenu
        self.menuId =  menuId
    }
    
    var title:String!
    var subTitle:String!
    var type:Int!//0带开关 1没有
    var icon:String!
    var masterMenu:Bool = false
    var menuId:String!
    
    static var menuList:[MainMenu]{
        var menuList:[MainMenu]=[MainMenu]()
        
        menuList.append( MainMenu(title: "物业公告",subTitle: "查看小区物业最新公告",type: 1,icon: "notice",masterMenu: false,menuId: "notice"))
        menuList.append(MainMenu(title: "门禁记录",subTitle: "查看来访以及开门记录",type: 1,icon: "log",masterMenu: false,menuId: "log"))
        menuList.append(MainMenu(title: "免扰模式",subTitle: "屏蔽该小区的消息推送",type: 0,icon: "not-disturb",masterMenu: false,menuId: "not-disturb"))
        menuList.append( MainMenu(title: "人脸识别",subTitle: "门禁机识别面孔即开门",type: 1,icon: "face",masterMenu: false,menuId: "face"))
        menuList.append(MainMenu(title: "电话通知",subTitle: "应对门铃无人响应状况",type: 1,icon: "tel",masterMenu: false,menuId: "tel"))
        menuList.append( MainMenu(title: "授权管理",subTitle: "授予其他用户使用门禁",type: 1,icon: "authorization",masterMenu: true,menuId: "authorization"))
        menuList.append(MainMenu(title: "租客模式",subTitle: "来访呼叫仅推送至租客",type: 0,icon: "tenant",masterMenu: true,menuId: "tenant"))
        return menuList
    }
    
    static var commonMenuList:[MainMenu]{
        var menuList:[MainMenu]=[MainMenu]()
        
        menuList.append( MainMenu(title: "物业公告",subTitle: "查看小区物业最新公告",type: 1,icon: "notice",masterMenu: false,menuId: "notice"))
        menuList.append(MainMenu(title: "门禁记录",subTitle: "查看来访以及开门记录",type: 1,icon: "log",masterMenu: false,menuId: "log"))
        menuList.append(MainMenu(title: "免扰模式",subTitle: "屏蔽该小区的消息推送",type: 0,icon: "not-disturb",masterMenu: false,menuId: "not-disturb"))
        menuList.append( MainMenu(title: "人脸识别",subTitle: "门禁机识别面孔即开门",type: 1,icon: "face",masterMenu: false,menuId: "face"))
        menuList.append(MainMenu(title: "电话通知",subTitle: "应对门铃无人响应状况",type: 1,icon: "tel",masterMenu: false,menuId: "tel"))
        
        return menuList
    }
    
    internal static func getMenuNum(master:Bool)->Int{
        if master{
            return self.menuList.count
        }else{
            var i=0
            for index in 0...menuList.count-1{
                if !menuList[index].masterMenu{
                    i += 1
                }
            }
            return i
        }
        
    }
    
    internal static func getMenuIndexById(list:[MainMenu],menuId:String)->Int{
        let defaultValue = -1
        for index in 0...list.count-1{
            if list[index].menuId == menuId{
                return index
            }
            
        }
        return defaultValue
    }
}