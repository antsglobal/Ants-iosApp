//
//  MenuTVCell.swift
//  ANTSDemo
//
//  Created by Kranthi on 10/16/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class MenuTVCell: UITableViewCell {

    @IBOutlet weak var menuItemsImages: UIImageView!
    @IBOutlet weak var menuNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
