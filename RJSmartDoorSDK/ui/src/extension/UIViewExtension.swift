//
//  UIViewExtension.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/20.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        gr.cancelsTouchesInView = false
        addGestureRecognizer(gr)
    }
    
}