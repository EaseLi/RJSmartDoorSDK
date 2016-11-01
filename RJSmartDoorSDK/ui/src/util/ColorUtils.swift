//
//  ColorUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/18.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

public class ColorUtils{
    
    static var colorList:[UIColor]{
        var colorList:[UIColor] = [UIColor]()
        colorList.append(UIColor.fromRGB("057BFF"))
        colorList.append(UIColor.fromRGB("FF3F66"))
        colorList.append(UIColor.fromRGB("F5A43B"))
        colorList.append(UIColor.fromRGB("3AC349"))
        colorList.append(UIColor.fromRGB("A954FF"))
        colorList.append(UIColor.fromRGB("3FB3FF"))
        return colorList
    }
    
    static func getColor(index:Int)->UIColor{
        let luckyBoy = index % colorList.count
        return colorList[luckyBoy]
    }
    
    
    
    
}