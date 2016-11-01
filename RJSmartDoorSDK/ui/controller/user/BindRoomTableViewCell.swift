//
//  BindRoomTableViewCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/6.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class BindRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var no: UILabel!
    
    @IBOutlet weak var node: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        no.textAlignment = .Center
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
