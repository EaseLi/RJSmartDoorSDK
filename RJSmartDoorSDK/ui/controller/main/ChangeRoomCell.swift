//
//  ChangeRoomCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/13.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class ChangeRoomCell: UITableViewCell {

    @IBOutlet weak var item: UIView!
   
    @IBOutlet weak var room: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        item.layer.masksToBounds = true
        item.layer.cornerRadius = 7
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
