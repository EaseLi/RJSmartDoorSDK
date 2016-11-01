//
//  NSUserDefaultsUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/29.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
public class NSUserDefaultsUtils{
    
    
    public static func setValue(key:String,value:String){
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: key)
    }
    public static func getString(key:String)-> String{
        let value = NSUserDefaults.standardUserDefaults().stringForKey(key)
        return (value != nil) ? value! : ""
    }
    
    
    public static func setInt(key:String,value:Int){
        NSUserDefaults.standardUserDefaults().setInteger(value, forKey: key)
    }
    public static func getInt(key:String)-> Int{
        return NSUserDefaults.standardUserDefaults().integerForKey(key)
    }
    
    
    public static func getObj(key:String)->AnyObject?{
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }
    public static func setObject(key:String,value:AnyObject){
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    }
    
    
    public static func setBool(key:String,value:Bool){
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: key)
    }
    public static func getBool(key:String)->Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey(key)
    }
    
    public static func remove(key:String){
        NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    public static func  saveCusObj(obj:AnyObject) {
        let docPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        let filePath = docPath.stringByAppendingPathComponent("cusobj.data");
        
        /**
         *  数据归档处理
         */
        NSKeyedArchiver.archiveRootObject(obj, toFile: filePath);
    }
    
    /**
     反归档数据
     */
    public static func readCusObj()->AnyObject? {
        let docPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        let filePath = docPath.stringByAppendingPathComponent("cusobj.data");
        let obj = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath)
        return obj
    }
}
