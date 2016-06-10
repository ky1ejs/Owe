//
//  Expense.swift
//  Owe
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import Foundation
import CoreData




class Expense: NSManagedObject, MOCUser {
    @NSManaged var title: String
    @NSManaged var desc: String?
    @NSManaged var amount: NSDecimalNumber
    @NSManaged var dateString: String
    var date: NSDate {
        get {
            return Timestamp.dateFromString(self.dateString)!
        }
        set {
            self.dateString = Timestamp.stringFromDate(newValue)
        }
    }
    @NSManaged var person: Person
    
    convenience init(title: String, desc: String?, amount: NSDecimalNumber, date: NSDate, person: Person) {
        let expenseEntity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: self.dynamicType.moc)!
        self.init(entity: expenseEntity, insertIntoManagedObjectContext: self.dynamicType.moc)
        self.title = title
        self.desc = desc
        self.amount = amount
        self.date = date
        self.person = person
    }
}
