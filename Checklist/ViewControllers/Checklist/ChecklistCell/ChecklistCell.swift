//
//  ChecklistCell.swift
//  Checklist
//
//  Created by Nitish on 20/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit

class ChecklistCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var imageViewChecklist: UIImageView!
    @IBOutlet weak var labelChecklistName: UILabel!
    @IBOutlet weak var labelDeadline: UILabel!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var imageViewReminder: UIImageView!
    @IBOutlet weak var constraintDateLeading: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
