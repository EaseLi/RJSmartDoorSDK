//
//  DateUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/22.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class DateUtils{
    
    static var dfmatter : NSDateFormatter {
        let df = NSDateFormatter()
        df.dateFormat="yyyyMMddHHmmssSSS"
        return df
    }
    
    public static func getTimeStamp()->String{
        return self.dfmatter.stringFromDate(NSDate())
    }
    
    public static func timeStampToData(timeStamp:String)->NSDate{
        return  dfmatter.dateFromString(timeStamp)!
    }
    
    public static func compareWithNow(timeStamp:String)->Int{
        let date = timeStampToData(timeStamp)
        let result = date.compare(NSDate())
        return result.rawValue
    }
    
    public static func checkTimeWithSecond(timeStamp:String,interval:Int)->Bool{
        let date = timeStampToData(timeStamp)
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let result = gregorian!.components(NSCalendarUnit.Second, fromDate: date, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        
        return result.second > interval
    }
    
    public static func compareTime(timeStampOne:String,timeStampTwo:String)->Int{
        let dateOne = timeStampToData(timeStampOne)
        let dateTwo = timeStampToData(timeStampTwo)
        let result = dateOne.compare(dateTwo)
        return result.rawValue
    }
    
}
