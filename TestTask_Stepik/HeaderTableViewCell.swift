//
//  HeaderTableViewCell.swift
//  TestTask_Stepik
//
//  Created by user on 01.05.17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel : UILabel!
    @IBOutlet weak var segControl : UISegmentedControl!
    @IBOutlet weak var enrollButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enrollButton.addBorderWith(color: mainColor(), width: 1)
        enrollButton.layer.cornerRadius = 21
        enrollButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
