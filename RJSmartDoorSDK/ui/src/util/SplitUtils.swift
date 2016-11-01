//
//  SplitUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/7.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
public class SplitUtils{
    
    public static func split(message:String) -> [String] {
        return message.componentsSeparatedByString("|")
    }
}

