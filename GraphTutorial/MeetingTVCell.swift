//
//  MeetingTVCell.swift
//  GraphTutorial
//
//  Created by Kranthi on 1/7/20.
//  Copyright © 2020 Jason Johnston. All rights reserved.
//

import UIKit

class MeetingTVCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var teamLocationLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
