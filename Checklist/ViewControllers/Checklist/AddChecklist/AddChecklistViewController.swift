//
//  AddChecklistViewController.swift
//  Checklist
//
//  Created by Nitish on 20/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import JGProgressHUD
import AudioToolbox

protocol OpenPickerDelegate {
    func openAlert(cell: AddChecklistCaptureCell)
}

class AddChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, OpenPickerDelegate {
    
    // IBOutlets
    @IBOutlet weak var tableChecklist: UITableView!
    
    // Variables
    let imagePicker = UIImagePickerController()
    var cellCapture: AddChecklistCaptureCell!
    var cellName: AddChecklistNameCell!
    var cellDescription: AddChecklistDescriptionCell!
    var cellTag: AddChecklistTagCell!
    var cellReminder: AddChecklistReminderCell!
    @IBOutlet weak var viewModel: AddChecklistViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.registerCustomCells()
    }
    
    func initializeUI() {
        self.title = "Add your checklist"
        let barbuttonClose = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))
        self.navigationItem.leftBarButtonItem = barbuttonClose
        let barButtonSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem = barButtonSave
        self.tableChecklist.estimatedRowHeight = 150
        self.tableChecklist.rowHeight = UITableViewAutomaticDimension
        self.tableChecklist.separatorStyle = .none
        imagePicker.delegate = self
    }
    
    func registerCustomCells() {
        let identifiers = ["AddChecklistCaptureCell", "AddChecklistNameCell", "AddChecklistDescriptionCell", "AddChecklistTagCell", "AddChecklistReminderCell"]
        self.viewModel.registerCell(identifiers: identifiers, table: self.tableChecklist)
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        if cellName.textFieldName.text != nil && cellName.textFieldName.text != "" {
            self.viewModel.saveChecklist(imageData: Data(), name: self.cellName.textFieldName.text!, desc: self.cellDescription.textViewDescription.text, tag: cellTag.tagChecklist, reminder: self.cellReminder.dateReminder!) { (message) -> Void in
                if message == "Success" {
                    UIView.hr_setToastThemeColor(color: Constants.kColorSuccess)
                    self.view.makeToast(message: "", duration: 2, position: HRToastPositionCenter as AnyObject, title: "Checklist saved")
                    AudioServicesPlayAlertSound(1007)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.cancel()
                    })
                } else {
                    UIView.hr_setToastThemeColor(color: UIColor.red)
                    self.view.makeToast(message: "Could not save", duration: 2, position: HRToastPositionCenter as AnyObject, title: "Error")
                }
            }
        } else {
            UIView.hr_setToastThemeColor(color: UIColor.red)
            self.view.makeToast(message: "Error", duration: 2, position: HRToastPositionCenter as AnyObject, title: "Please enter name")
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddChecklistCaptureCell", for: indexPath) as? AddChecklistCaptureCell else {
                fatalError("Unexpected Index Path")
            }
            
            cell.selectionStyle = .none
            cell.delegateImage = self
            
            return cell
        case 1:
            self.cellName = tableView.dequeueReusableCell(withIdentifier: "AddChecklistNameCell", for: indexPath) as? AddChecklistNameCell
            self.cellName.selectionStyle = .none
            return self.cellName
        case 2:
            self.cellDescription = tableView.dequeueReusableCell(withIdentifier: "AddChecklistDescriptionCell", for: indexPath) as? AddChecklistDescriptionCell
            self.cellDescription.selectionStyle = .none
            return self.cellDescription
        case 3:
            self.cellTag = tableView.dequeueReusableCell(withIdentifier: "AddChecklistTagCell", for: indexPath) as? AddChecklistTagCell
            self.cellTag.selectionStyle = .none
            return self.cellTag
        case 4:
            self.cellReminder = tableView.dequeueReusableCell(withIdentifier: "AddChecklistReminderCell", for: indexPath) as? AddChecklistReminderCell
            self.cellReminder.selectionStyle = .none
            return self.cellReminder
        default:
            return UITableViewCell()
        }
    }
    
    func openAlert(cell: AddChecklistCaptureCell) {
        self.cellName.textFieldName.resignFirstResponder()
        self.cellDescription.textViewDescription.resignFirstResponder()
        self.cellCapture = cell
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = cell.imageViewChecklist
            alert.popoverPresentationController?.sourceRect = cell.imageViewChecklist.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cellCapture.imageViewChecklist.image = pickedImage
            cellCapture.viewImageView.isHidden = true
            cellCapture.buttonCamera.isHidden = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
