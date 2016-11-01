//
//  SecrecyUtils.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/21.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
import CryptoSwift

public class SecrecyUtils{
    
    public class func sha256(plaintext:String) ->String{
        return plaintext.isEmpty ? "" : plaintext.sha256().uppercaseString
    }
    
    public class func sha256(plaintext:String,salt:String) ->String{
        return sha256(salt+sha256(plaintext))
    }
    
}
