//
//  Stack.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/6.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    mutating func clear(){
        items.removeAll()
    }
}