//
//  ImageExtension.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/4.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    static func scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    static func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func aspectToFill(image: UIImage, newSize: CGSize)-> UIImage{
        
        let tempImg = UIImage.resizeImage(image, newSize: UIImage.scaleImage(image, imageLength: max(newSize.height, newSize.width)))
        
        let contextImage: UIImage = UIImage(CGImage: tempImg.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = newSize.width
        var cgheight: CGFloat = newSize.height
        
        // See what size is longer and create the center off of that
        if contextSize.height > contextSize.width {
            posX = ((contextSize.width - newSize.width) / 2)
            posY = 0
            cgwidth = newSize.width
            cgheight = newSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - newSize.height) / 2)
            cgwidth = newSize.width
            cgheight = newSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage!, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: 1, orientation: image.imageOrientation)
        
        return image
        
        //        return tempImg
        
        
        
        
        //        let goalH = fillSize.height
        //        let goalW = fillSize.width
        //
        //        let originalH = image.size.height
        //        let originalW = image.size.width
        //        //判断裁宽还是高
        //        if (goalH/goalW > originalH/originalW){
        //             //裁宽
        //            UIGraphicsBeginImageContext(fillSize)
        //            image.drawInRect(CGRect(x: 0, y: 0, width: goalW, height: originalH))
        //
        //            let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //            UIGraphicsEndImageContext()
        //
        //            return newImage
        //        }else{
        //            //裁高
        //            UIGraphicsBeginImageContext(fillSize)
        //            image.drawInRect(CGRect(x: 0, y: (goalH-originalH)/2, width: originalW, height: goalH))
        //
        //            let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //            UIGraphicsEndImageContext()
        //
        //            return newImage
        //        }
        
        //        let contextImage: UIImage = UIImage(CGImage: image.CGImage!)
        //
        //        let contextSize: CGSize = contextImage.size
        //
        //        var posX: CGFloat = 0.0
        //        var posY: CGFloat = 0.0
        //        var cgwidth: CGFloat = newSize.width
        //        var cgheight: CGFloat = newSize.height
        //
        //        // See what size is longer and create the center off of that
        //        if contextSize.width > contextSize.height {
        //            posX = ((contextSize.width - newSize.width) / 2)
        //            posY = 0
        //            cgwidth = newSize.width
        //            cgheight = newSize.height
        //        } else {
        //            posX = 0
        //            posY = ((contextSize.height - newSize.height) / 2)
        //            cgwidth = newSize.width
        //            cgheight = newSize.width
        //        }
        //
        //        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        //
        //        // Create bitmap image from context using the rect
        //        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        //
        //        // Create a new image based on the imageRef and rotate back to the original orientation
        //        let image: UIImage = UIImage(CGImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        //        
        //        return image
        
    }
    
}
