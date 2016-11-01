//
//  SwiftCountdownButton.swift
//
//  Created by Gesen on 15/6/4.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

class CountdownButton: UIButton {
    
    // MARK: Properties
    
    var maxSecond:Int = 60
    var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    private var second = 0
    private var timer: NSTimer?
    
    private var timeLabel: UILabel!
    private var normalText: String!
    private var normalTextColor: UIColor!
    private var disabledText: String!
    private var disabledTextColor: UIColor!
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    deinit {
        countdown = false
    }
    
  
    // MARK: Private
    
    private func startCountdown() {
        second = maxSecond
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(CountdownButton.updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        enabled = true
        self.backgroundColor = UIColor.fromRGB("4ba0ff")
        
    }
    
    private func updateDisabled() {
        enabled = false
        self.backgroundColor=UIColor.grayColor()
        self.setTitle(String(second)+"s" , forState: .Disabled)

    }
    
    @objc private func updateCountdown() {
        second -= 1
        if second <= 0 {
            countdown = false
        } else {
            updateDisabled()
        }
    }
    
}
