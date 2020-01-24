//
//  projectDetailsTVCell.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/31/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class projectDetailsTVCell: UITableViewCell {
    @IBOutlet weak var projectImgView: UIImageView!
    
    @IBOutlet weak var viewProjectBtn: UIButton!
    @IBOutlet weak var durationTimeLbll: UILabel!
    @IBOutlet weak var domainTypeLbl: UILabel!
    @IBOutlet weak var projectNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
