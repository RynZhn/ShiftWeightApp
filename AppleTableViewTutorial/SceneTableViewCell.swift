//
//  MealTableViewCell.swift
//  AppleTableViewTutorial
//
//  Created by Ryan Zhan on 2/8/18.
//  Copyright © 2018 QL+. All rights reserved.
//

import UIKit

class SceneTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    override func awakeFromNib() {

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
