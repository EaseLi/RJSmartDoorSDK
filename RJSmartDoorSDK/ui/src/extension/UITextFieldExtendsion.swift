//
//  UITextFieldExtendsion.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/20.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 6, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 6, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
    }
    
    func validateLength(min:Int,max:Int) -> Bool {
        return (self.text!.characters.count >= min) && (self.text!.characters.count <= max)
    }
    
    func validateMaxLength(max:Int) -> Bool {
        return self.text!.characters.count >= max
    }
    
    func validateMinLength(min:Int) -> Bool {
        return self.text!.characters.count <= min
    }
}