//
//  AddChecklistCaptureCell.swift
//  Checklist
//
//  Created by Nitish on 23/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit

class AddChecklistCaptureCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // IBOutlets
    @IBOutlet weak var viewImageView: UIView!
    @IBOutlet weak var imageViewChecklist: UIImageView!
    @IBOutlet weak var buttonCamera: UIButton!
    @IBOutlet weak var labelImageDescription: UILabel!
    
    var delegateImage: OpenPickerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewImageView.layer.borderColor = UIColor.white.cgColor
        self.viewImageView.layer.borderWidth = 0.7
        self.viewImageView.layer.cornerRadius = 5
        
        
        let gesturePicker = UITapGestureRecognizer(target: self, action: #selector(self.openAlert(sender:)))
        self.imageViewChecklist.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(gesturePicker)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func openAlert(sender: UITapGestureRecognizer) {
        self.delegateImage.openAlert(cell: self)
    }
    
    @IBAction func openImagePicker(sender: UIButton) {
        
    }
    
    
}
