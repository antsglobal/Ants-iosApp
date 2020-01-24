//
//  MeetingListTVCell.swift
//  ANTSDemo
//
//  Created by Kranthi on 11/1/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit

class MeetingListTVCell: UITableViewCell {

    @IBOutlet weak var projectNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var teamLocationLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var subject: String? {
           didSet {
               projectNameLbl.text = subject
           }
       }
       
       var organizer: String? {
           didSet {
               teamLocationLbl.text = organizer
           }
       }
       
       var duration: String? {
           didSet {
               timeLbl.text = duration
           }
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
