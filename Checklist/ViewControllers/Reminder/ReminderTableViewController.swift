//
//  ReminderTableViewController.swift
//  Checklist
//
//  Created by Nitish on 20/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import CoreData

class ReminderTableViewController: UITableViewController {
    
    @IBOutlet weak var viewModel: ReminderViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "ReminderCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.viewModel.initialiseFetchController(delegate: self)
        self.viewModel.loadReminderTable()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 10
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderCell
        cell.selectionStyle = .none
        
        let checklist = self.viewModel.remonderRowIndexPath(indexPath: indexPath)
        cell.labelDate.text = checklist.deadline
        cell.labelChecklistName.text = checklist.name
        
        return cell
    }
}

extension ReminderTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}
