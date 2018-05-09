//
//  ReminderViewModel.swift
//  Checklist
//
//  Created by Nitish on 09/05/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewModel: NSObject {
    
    var persistentContainer = NSPersistentContainer(name: "Checklist")
    var fetchedResultsController: NSFetchedResultsController<Checklist>!
    
    override init() {
        
    }
    
    func initialiseFetchController(delegate: NSFetchedResultsControllerDelegate) {
        self.fetchedResultsController = {
            let fetchRequest: NSFetchRequest<Checklist> = Checklist.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "deadline != nil")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = delegate
            return fetchedResultsController
        }()
    }
    
    func loadReminderTable() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch (_) {
            
        }
    }
    
    func numberOfSections() -> Int {
        guard let checklists = fetchedResultsController.fetchedObjects else
        {
            return 0
        }
        
        return checklists.count
    }
    
    func remonderRowIndexPath(indexPath: IndexPath) -> Checklist {
        var checklist = Checklist()
        let sectionInfo = self.fetchedResultsController.sections![indexPath.row] as NSFetchedResultsSectionInfo
        if sectionInfo.numberOfObjects > indexPath.section {
            checklist = sectionInfo.objects![indexPath.section] as! Checklist
        }
        
        return checklist
    }
}
