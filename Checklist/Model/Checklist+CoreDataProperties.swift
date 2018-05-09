//
//  Checklist+CoreDataProperties.swift
//  
//
//  Created by Nitish on 24/04/18.
//
//

import Foundation
import CoreData


extension Checklist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Checklist> {
        return NSFetchRequest<Checklist>(entityName: "Checklist")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var tag: Int64
    @NSManaged public var deadline: String?

}
