//
//  RegexUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/13.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class RegexUtils{


    public static func mobile(mobile:String)->Bool{
        let mailPattern = "^[0-9]{11}$"
        let matcher = Regex(mailPattern)
        return matcher.match(mobile)
        
    }
    
    public static func phone(mobile:String)->Bool{
        let mailPattern = "^[0-9]{12}$"
        let matcher = Regex(mailPattern)
        return matcher.match(mobile)
        
    }
    
    public static func qrcode(code:String)->Bool{
        let mailPattern = "^[0-9]{6}$"
        let matcher = Regex(mailPattern)
        return matcher.match(code)
    }
    
    public static func num(num:String)->Bool{
        let mailPattern = "\\d*"
        let matcher = Regex(mailPattern)
        return matcher.match(num)
    }
}