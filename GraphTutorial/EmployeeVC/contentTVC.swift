//
//  contentTVC.swift
//  ExpandAndCollapseTVDemo
//
//  Created by Prashanth on 25/10/19.
//  Copyright © 2019 Vsoft. All rights reserved.
//

import UIKit

class contentTVC: UITableViewCell {

    @IBOutlet weak var viewAllButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var selectedAccountButton: UIButton!
    @IBOutlet weak var empNameLabel: UILabel!
    
    @IBOutlet weak var companyLocationLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
