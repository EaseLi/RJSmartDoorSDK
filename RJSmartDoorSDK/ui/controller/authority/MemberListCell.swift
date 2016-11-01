//
//  MemberListCell.swift
//  RJSmartDoor
//
//  Created by Ruijia on 16/7/11.
//  Copyright © 2016年 Ruijia. All rights reserved.
//

import UIKit

class MemberListCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var describe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
