//
//  AlertController.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

public class AlertController{
    
    public static func instance(title:String,message:String,cancelTitle:String,cancelHandler:(UIAlertAction)->Void,okTitle:String,okHandler:(UIAlertAction)->Void) ->UIAlertController{
        let alertController = UIAlertController(title: title,  message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .Cancel, handler: cancelHandler)
        let okAction = UIAlertAction(title: okTitle, style: .Default, handler:okHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        return alertController
    }
}