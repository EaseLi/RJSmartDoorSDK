//
//  HTTPStatusCode.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/22.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

struct HttpStatusCode {
    
    init(CODE:Int, MESSAGE:String) {
        self.CODE = CODE
        self.MESSAGE = MESSAGE
    }
    
    let CODE:Int
    let MESSAGE:String
    
    static let SUCCESS=HttpStatusCode(CODE: 200, MESSAGE: "成功")
    
}