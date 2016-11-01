//
//  TransactionNoUtil.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/27.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class TransactionNoUtils {
    static func generate(household_id:String)->String{
        return "i" + DateUtils.getTimeStamp() + household_id
    }
}
