//
//  RingService.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/1.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import AudioToolbox

public class RingService{
    //1.获取系统声音ID
    static var soundID:SystemSoundID = 0
    
    public static func playSound(){
        //获取文件的路径
        let path = NSBundle.mainBundle().pathForResource("ring", ofType: "m4a")
        let baseURL = NSURL(fileURLWithPath: path!)
        
        
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //        AudioServicesPlayAlertSound(soundID)
        
        AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, nil, nil, {(soundID, _)
            in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) })
            }
            , nil)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        
        AudioServicesPlaySystemSound(soundID);
        
    }
    
    
    public static func stopSound(){
        AudioServicesDisposeSystemSoundID(soundID)
        AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
        AudioServicesRemoveSystemSoundCompletion(soundID);
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
    }
    
    
}