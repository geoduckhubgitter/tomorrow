//
//  Task+CoreDataProperties.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: NSDate
    @NSManaged public var title: String
    @NSManaged public var priority: Float
    @NSManaged public var complete: Bool
}
