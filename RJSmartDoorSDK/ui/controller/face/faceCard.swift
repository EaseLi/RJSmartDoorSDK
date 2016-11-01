//
//  faceCard.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/9/30.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class faceCard: UIView {
    
    @IBOutlet weak var face: UIImageView!
    @IBOutlet weak var face_id: UILabel!
    @IBOutlet weak var persion_id: UILabel!

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
        let nib = UINib(nibName: "faceCard", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
        
        
        
    }

}
