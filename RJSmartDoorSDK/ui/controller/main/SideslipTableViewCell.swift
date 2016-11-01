//
//  SideslipTableViewCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/6/16.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class SideslipTableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var icon: UIImageView!
    

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.layoutIfNeeded()
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = icon.bounds.width/2
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
