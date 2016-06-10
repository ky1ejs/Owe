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

class OweTests: XCTestCase {
    func testCalculationsWithTwoPeople() {
        
        let person1 = Person(name: "Person 1")
        let person2 = Person(name: "Person 2")
        
        _ = Expense(amount: 120, desc: "test expense", title: "Expense 1", person: person1)
        
        do {
            try MoneyOwed.calculateForPeople([person1, person2])
            let owed = try MoneyOwed.forPerson(person1)
            XCTAssertEqual(owed.count, 1)
            XCTAssertEqual(owed.first?.amount, -60)
            XCTAssertEqual(owed.first?.sender, person1)
            XCTAssertEqual(owed.first?.recipient, person2)
        } catch { XCTFail("Something threw") }
    }
    
    func testCalculationsWith4People() {
        
    }
}
