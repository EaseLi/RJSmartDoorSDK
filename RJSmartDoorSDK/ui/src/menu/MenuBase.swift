//
//  MenuBase.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/8.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

public class MenuBase:NSObject {
    
    
    public static func push2View(view:UIViewController,identifier:String) {
        //        dispatch_async(dispatch_get_main_queue()) {
        
        var exist:Bool = false
        
        if view.navigationController?.viewControllers.count>0 {
            for vc: UIViewController in (view.navigationController?.viewControllers)! {
                let name =  NSStringFromClass(object_getClass(vc))

                if (name.containsString(identifier)) {
                    exist = true
                    view.navigationController!.popToViewController(vc, animated: true)
                    break
                }
            }
        }
        
        
        
        if !exist{
            let viewController = view.storyboard!.instantiateViewControllerWithIdentifier(identifier)
          
            view.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
        
        //        }
    }
    
    public static func push2View(view:UIViewController,storyboardId:String,identifier:String,title:String) {
        
        var exist:Bool = false
        
        if view.navigationController?.viewControllers.count>0 {
            for vc: UIViewController in (view.navigationController?.viewControllers)! {
                let name =  NSStringFromClass(object_getClass(vc))
                
                if (name.containsString(identifier)) {
                    exist = true
                    vc.title = title
                    view.navigationController!.popToViewController(vc, animated: true)
                    break
                }
            }
        }
        
        
        if !exist{
            let storyboard = UIStoryboard(name: storyboardId,bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier(identifier)
            viewController.title = title
            view.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    
}
