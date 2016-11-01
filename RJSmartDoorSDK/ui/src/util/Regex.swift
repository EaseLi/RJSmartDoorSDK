//
//  Regex.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/13.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import Foundation
struct Regex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern,
                                         options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matchesInString(input,
                                                options: [],
                                                range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}