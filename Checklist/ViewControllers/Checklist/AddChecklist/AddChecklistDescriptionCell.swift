//
//  AddChecklistDescriptionCell.swift
//  Checklist
//
//  Created by Nitish on 23/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class AddChecklistDescriptionCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var textViewDescription: KMPlaceholderTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textViewDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.textViewDescription.layer.borderWidth = 0.7
        self.textViewDescription.layer.shadowColor = UIColor.lightGray.cgColor
        self.textViewDescription.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.textViewDescription.layer.shadowOpacity = 1.0
        self.textViewDescription.layer.shadowRadius = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
