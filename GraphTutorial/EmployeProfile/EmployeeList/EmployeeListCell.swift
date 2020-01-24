//
//  EmployeeListCell.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/30/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class EmployeeListCell: UITableViewCell {

    @IBOutlet weak var viewProfileBtn: UIButton!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var empName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
