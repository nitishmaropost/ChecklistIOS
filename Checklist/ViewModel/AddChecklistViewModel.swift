//
//  AddChecklistViewModel.swift
//  Checklist
//
//  Created by Nitish on 08/05/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class AddChecklistViewModel: NSObject {
    
    var imageData: Data!
    var name: String!
    var descriptionChecklist: String!
    var tag: String!
    var dateReminder: Date!
    
    override init() {
        
    }
    
    init(imageData: Data, name: String, desc: String, tag: String, reminder: Date) {
        self.imageData = imageData
        self.name = name
        self.descriptionChecklist = desc
        self.tag = tag
        self.dateReminder = reminder
    }
    
    func registerCell(identifiers: [String], table: UITableView) {
        for identifier in identifiers {
            table.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func saveChecklist(imageData: Data, name: String, desc: String, tag: Int, reminder: String, completion:@escaping (_ message: String) -> Void) {
        var message = "Success"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Checklist", in: context)
        let checklist = NSManagedObject(entity: entity!, insertInto: context)
        checklist.setValue(name, forKey: "name")
        checklist.setValue(desc, forKey: "details")
        checklist.setValue(tag, forKey: "tag")
        checklist.setValue(reminder, forKey: "deadline")
        do {
            try context.save()
        } catch (_) {
            message = "Error"
        }
        
        if reminder != nil && reminder != "" {
            self.addEvent(name: name, desc: desc, tag: tag, reminder: reminder)
        }
        
        completion(message)
    }
    
    func addEvent(name: String, desc: String, tag: Int, reminder: String) {
        let eventStore = EKEventStore();
        
        // Use Event Store to create a new calendar instance
        if let calendarForEvent = eventStore.defaultCalendarForNewEvents
        {
            let newEvent = EKEvent(eventStore: eventStore)
            
            newEvent.calendar = calendarForEvent
            newEvent.title = name
            newEvent.startDate = self.getReminderDateString(reminderDate: reminder)
            newEvent.endDate = self.getReminderDateString(reminderDate: reminder)
            let alarm = EKAlarm(absoluteDate: newEvent.startDate)
            newEvent.addAlarm(alarm)
            do {
                try eventStore.save(newEvent, span: .thisEvent, commit: true)
            } catch {
                
            }
        }
    }
    
    func getReminderDateString(reminderDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        return formatter.date(from: reminderDate)!
    }
}
