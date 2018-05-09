//
//  ChecklistTableViewController.swift
//  Checklist
//
//  Created by Nitish on 20/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import CoreData

class ChecklistTableViewController: UITableViewController {
    
    @IBOutlet weak var viewModel: ChecklistTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "ChecklistCell", bundle: nil), forCellReuseIdentifier: "ChecklistCell")
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.viewModel.initialiseFetchController(delegate: self)
        self.viewModel.loadChecklistTable()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 10
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath) as? ChecklistCell else {
            fatalError("Unexpected Index Path")
        }
        
        let checklist = self.viewModel.checkListRowIndexPath(indexPath: indexPath)
        cell.labelChecklistName.text = checklist.name
        cell.labelDeadline.text = "23rd May 2018"
        cell.imageViewChecklist.image = UIImage(named: "grocery.png")
        switch checklist.tag {
        case 0:
            cell.viewColor.backgroundColor = Constants.kColorGrocery
            cell.layer.borderColor = Constants.kColorGrocery.cgColor
            cell.imageViewChecklist.image = UIImage(named: "grocery.png")
        case 1:
            cell.viewColor.backgroundColor = Constants.kColorTravel
            cell.layer.borderColor = Constants.kColorTravel.cgColor
            cell.imageViewChecklist.image = UIImage(named: "travel.png")
        case 2:
            cell.viewColor.backgroundColor = Constants.kColorMovie
            cell.layer.borderColor = Constants.kColorMovie.cgColor
            cell.imageViewChecklist.image = UIImage(named: "movie.png")
        case 3:
            cell.viewColor.backgroundColor = Constants.kColorWork
            cell.layer.borderColor = Constants.kColorWork.cgColor
            cell.imageViewChecklist.image = UIImage(named: "work.png")
        default:
            cell.viewColor.backgroundColor = Constants.kColorGrocery
            cell.layer.borderColor = Constants.kColorGrocery.cgColor
            cell.imageViewChecklist.image = UIImage(named: "grocery.png")
        }
        
        if checklist.deadline == nil || checklist.deadline == "" {
            cell.labelDeadline.text = checklist.details
            cell.imageViewReminder.isHidden = true
            cell.constraintDateLeading.constant = 70
        }
        
        cell.selectionStyle = .none
        cell.layer.borderWidth = 0.7
        cell.layer.cornerRadius = 5
        return cell
    }
}

extension ChecklistTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}
