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
    @NSManaged var person: Person
    
    convenience init(amount: NSDecimalNumber, desc: String, title: String, person: Person) {
        let expenseEntity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: self.dynamicType.moc)!
        self.init(entity: expenseEntity, insertIntoManagedObjectContext: self.dynamicType.moc)
        self.amount = amount
        self.desc = desc
        self.title = title
        self.person = person
    }
}
