//
//  CustomCell.swift
//  ChatApp1
//
//  Created by 小川智也 on 2020/03/14.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
