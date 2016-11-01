//
//  Card.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/20.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class Card: UIView {

    @IBOutlet weak var community: UILabel!
    
    
    @IBOutlet weak var doorName: UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Card", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
        
        
        
    }
    
//    class func instanceFromNib() -> UIView {
//        return UINib(nibName: "Card", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
//    }

}
