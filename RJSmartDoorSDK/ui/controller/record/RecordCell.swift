//
//  RecordCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/18.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var record: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
