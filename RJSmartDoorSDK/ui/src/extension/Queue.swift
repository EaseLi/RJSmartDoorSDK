//
//  Queue.swift
//  RJSmartDoor
//
//  Created by Ruijia on 2016/10/25.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
class Queue {
    var queue: [AnyObject]
    init() {
        queue = [AnyObject]()
    }
    func enqueue(object: AnyObject) {
        queue.append(object)
    }
    func dequeue() -> AnyObject? {
        if !isEmpty() {
            return queue.removeFirst()
        } else {
            return nil
        }
    }
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
    func peek() -> AnyObject? {
        return queue.first
    }
    func size() -> Int {
        return queue.count
    }
}
