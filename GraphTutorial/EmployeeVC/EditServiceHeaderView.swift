//
//  EditServiceHeaderView.swift
//  Arya3.0
//
//  Created by Prasanth Podalakur on 10/05/19.
//  Copyright © 2019 Vsoft. All rights reserved.
//

import UIKit


protocol EditAccessExpandableHeaderVDelegate {
    func toggleSection(header: EditServiceHeaderView, section: Int,selectionButton:UIButton)
}

class EditServiceHeaderView: UITableViewHeaderFooterView {

    var delegate: EditAccessExpandableHeaderVDelegate?
    var section: Int!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var selectedAccountButton: UIButton!
    override func awakeFromNib (){
       // self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! EditServiceHeaderView
//        delegate?.toggleSection(header: self, section: cell.section, selectionButton: <#UIButton#>)
    }
    func customInit(title: String, section: Int, delegate: EditAccessExpandableHeaderVDelegate?) {
        self.headerTitleLabel.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @IBAction func CheckMArkButtonTapped(_ sender: UIButton) {
//        let cell = sender.superview as! EditServiceHeaderView
        delegate?.toggleSection(header: self, section: self.section, selectionButton: sender)
    }
    
}
