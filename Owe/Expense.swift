//
//  Expense.swift
//  Owe
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import Foundation
import CoreData


class Expense: NSManagedObject {
    @NSManaged var amount: NSDecimalNumber?
    @NSManaged var desc: String?
    @NSManaged var title: String?
    @NSManaged var person: Person?
}
