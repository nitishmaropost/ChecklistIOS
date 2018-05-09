//
//  AddChecklistTagCell.swift
//  Checklist
//
//  Created by Nitish on 23/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit

class AddChecklistTagCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var stackViewTags: UIStackView!
    @IBOutlet weak var buttonGrocery: UIButton!
    @IBOutlet weak var buttonWork: UIButton!
    @IBOutlet weak var buttonMovie: UIButton!
    @IBOutlet weak var buttonTravel: UIButton!
    @IBOutlet weak var labelChecklistType: UILabel!
    var tagChecklist = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonWork.layer.cornerRadius = self.buttonWork.frame.size.width/2
        self.buttonMovie.layer.cornerRadius = self.buttonMovie.frame.size.width/2
        self.buttonTravel.layer.cornerRadius = self.buttonTravel.frame.size.width/2
        self.buttonGrocery.layer.cornerRadius = self.buttonGrocery.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setTag(sender: UIButton) {
        switch sender.tag {
        case 1:
            self.labelChecklistType.text = "Grocery"
            self.buttonGrocery.setImage(UIImage(named: "check.png"), for: .normal)
            self.buttonWork.setImage(nil, for: .normal)
            self.buttonMovie.setImage(nil, for: .normal)
            self.buttonTravel.setImage(nil, for: .normal)
            self.tagChecklist = 0
        case 2:
            self.labelChecklistType.text = "Travel"
            self.buttonTravel.setImage(UIImage(named: "check.png"), for: .normal)
            self.buttonWork.setImage(nil, for: .normal)
            self.buttonMovie.setImage(nil, for: .normal)
            self.buttonGrocery.setImage(nil, for: .normal)
            self.tagChecklist = 1
        case 3:
            self.labelChecklistType.text = "Movie"
            self.buttonMovie.setImage(UIImage(named: "check.png"), for: .normal)
            self.buttonWork.setImage(nil, for: .normal)
            self.buttonGrocery.setImage(nil, for: .normal)
            self.buttonTravel.setImage(nil, for: .normal)
            self.tagChecklist = 2
        case 4:
            self.labelChecklistType.text = "Work"
            self.buttonWork.setImage(UIImage(named: "check.png"), for: .normal)
            self.buttonGrocery.setImage(nil, for: .normal)
            self.buttonMovie.setImage(nil, for: .normal)
            self.buttonTravel.setImage(nil, for: .normal)
            self.tagChecklist = 3
        default:
            print("")
        }
    }
}
