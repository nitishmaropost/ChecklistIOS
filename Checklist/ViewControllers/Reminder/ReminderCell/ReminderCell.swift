//
//  ReminderCell.swift
//  Checklist
//
//  Created by Nitish on 09/05/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {

    @IBOutlet weak var imageViewClock: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelChecklistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.borderColor = Constants.kColorViewReminders.cgColor
        self.layer.borderWidth = 0.7
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.imageViewClock.image = self.imageViewClock.image?.withRenderingMode(.alwaysTemplate)
    }
}
