//
//  CircularCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/8/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class CircularCell: UITableViewCell {

    @IBOutlet weak var circularText: UILabel!
    @IBOutlet weak var news: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        news.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
