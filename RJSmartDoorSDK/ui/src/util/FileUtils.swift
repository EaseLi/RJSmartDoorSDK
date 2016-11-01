//
//  FileUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/12.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class FileUtils{
    
  
    static func generateFileName(household_id:String)->String{
        return household_id+"_"+DateUtils.getTimeStamp()+".jpg"
    }
    
    
}