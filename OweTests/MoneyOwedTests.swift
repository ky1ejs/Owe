//
//  OweTests.swift
//  OweTests
//
//  Created by Kyle McAlpine on 10/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import XCTest
import CoreData
@testable import Owe

class OweTests: XCTestCase, MOCUser {
    func testCalculations() {
        let personEntity = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.dynamicType.moc)!
        
        let person1 = Person(entity: personEntity, insertIntoManagedObjectContext: self.dynamicType.moc)
        person1.name = "Person 1"
        
        let person2 = Person(entity: personEntity, insertIntoManagedObjectContext: self.dynamicType.moc)
        person2.name = "Person 2"
        
        let expenseEntity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: self.dynamicType.moc)!
        let expense = Expense(entity: expenseEntity, insertIntoManagedObjectContext: self.dynamicType.moc)
        expense.person = person1
        expense.title = "Expense 1"
        expense.amount = 120
        expense.desc = "test expense"
        
        do {
            try MoneyOwed.calculateForPeople([person1, person2])
            let owed = try MoneyOwed.forPerson(person1)
            XCTAssertEqual(owed.count, 1)
            XCTAssertEqual(owed.first?.amount, -60)
            XCTAssertEqual(owed.first?.sender, person1)
            XCTAssertEqual(owed.first?.recipient, person2)
        } catch { XCTFail("Something threw") }
    }
}
