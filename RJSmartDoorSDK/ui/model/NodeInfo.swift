//
//  NodeInfo.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/6.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
struct NodeInfo {
    
    let node_id:Int
    let name:String
    
    init(node_id:Int,name:String){
        self.node_id=node_id
        self.name=name
    }
}
