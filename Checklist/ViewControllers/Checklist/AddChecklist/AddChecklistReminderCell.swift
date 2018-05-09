//
//  AddChecklistReminderCell.swift
//  Checklist
//
//  Created by Nitish on 23/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import DateTimePicker

class AddChecklistReminderCell: UITableViewCell, UITextFieldDelegate {

    // IBOutlets
    @IBOutlet weak var switchReminder: UISwitch!
    @IBOutlet weak var textFieldReminderDate: UITextField!
    var picker: DateTimePicker!
    var dateReminder: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textFieldReminderDate.setBottomBorder()
        self.textFieldReminderDate.leftViewMode = .always
        self.textFieldReminderDate.delegate = self
        let image = UIImage(named: "clock.png")
        let imageView = UIImageView(frame: CGRect(x: 3, y: 0, width: 18, height: 18))
        imageView.image = image
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate) 
        imageView.tintColor = Constants.kColorViewChecklist
        self.textFieldReminderDate.leftView = imageView
    }
    
    func setDatePicker() {
        picker = DateTimePicker.show()
        picker.highlightColor = Constants.kColorViewChecklist
        picker.doneBackgroundColor = Constants.kColorViewChecklist
        picker.completionHandler = { date in
            self.dateReminder = self.picker.selectedDateString
            self.textFieldReminderDate.text = self.picker.selectedDateString
        }
    }
    
    @IBAction func setReminder(sender: UISwitch) {
        if self.switchReminder.isOn {
            self.textFieldReminderDate.isHidden = false
        } else {
            self.textFieldReminderDate.isHidden = true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.setDatePicker()
        return false
    }
}
