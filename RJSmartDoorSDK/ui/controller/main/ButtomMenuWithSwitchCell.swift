//
//  SlideMenuTableViewWithSwitchCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/10.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class ButtomMenuWithSwitchCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var power: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
