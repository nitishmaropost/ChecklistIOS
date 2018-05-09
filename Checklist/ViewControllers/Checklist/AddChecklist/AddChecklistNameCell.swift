//
//  AddChecklistNameCell.swift
//  Checklist
//
//  Created by Nitish on 23/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit

class AddChecklistNameCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var textFieldName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textFieldName.setBottomBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
