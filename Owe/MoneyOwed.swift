//
//  MoneyOwed.swift
//  Owe
//
//  Created by Kyle McAlpine on 10/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

private var peopleIndexs = [Person : Int]()
private var globalOwed = [[MoneyOwed?]]()

enum ErrorTing: ErrorType {
    case Error
}

struct MoneyOwed: MOCUser {
    let sender: Person
    let recipient: Person
    let amount: Double
    
    static func forPerson(person: Person) throws -> [MoneyOwed] {
        guard let index = peopleIndexs[person] else { throw ErrorTing.Error }
        return globalOwed[index].flatMap() { $0 }
    }
    
    static func recalculate() throws {
        let personFetch = NSFetchRequest(entityName: "Person")
        guard let people = try self.moc.executeFetchRequest(personFetch) as? [Person] else { return }
        try self.calculateForPeople(people)
    }
    
    static func calculateForPeople(people: [Person]) throws {
        for i in 0..<people.count { peopleIndexs[people[i]] = i }
        
        var expensesGroupedByPerson = [[Expense]]()
        for person in people {
            guard let expenses = person.expenses?.allObjects as? [Expense] else { continue }
            expensesGroupedByPerson.append(expenses)
        }
        
        var totals = [Double]()
        for personsExpenses in expensesGroupedByPerson {
            var total: Double = 0
            for expense in personsExpenses {
                total += expense.amount?.doubleValue ?? 0
            }
            totals.append(total)
        }
        
        let totalPeople = Double(expensesGroupedByPerson.count)
        let totalSpent = totals.reduce(0, combine: +)
        let totalSpentEach = totalSpent / totalPeople
        
        var owed = totals.map() { $0 - totalSpentEach }
        
        var owedMatrix = [[MoneyOwed?]]()
        for _ in expensesGroupedByPerson {
            owedMatrix.append(Array(count: expensesGroupedByPerson.count, repeatedValue: nil))
        }
        
        for _ in 0..<expensesGroupedByPerson.count - 1 {
            let maxAmount = owed.maxElement()!
            let minAmount = owed.minElement()!
            
            let recipientIndex = owed.indexOf(maxAmount)!
            let senderIndex = owed.indexOf(minAmount)!
            
            let difference = maxAmount + minAmount
            let personIndexWithRemaingBalance = difference > 0 ? recipientIndex : senderIndex
            let balancedPersonIndex = difference <= 0 ? recipientIndex : senderIndex
            owed[personIndexWithRemaingBalance] = difference
            owed[balancedPersonIndex] = 0
            
            let smallestAmount = min(abs(minAmount), abs(maxAmount))
            let sender = people[senderIndex]
            let recipient = people[recipientIndex]
            let send = MoneyOwed(sender: sender, recipient: recipient, amount: smallestAmount)
            let receive = MoneyOwed(sender: recipient, recipient: sender, amount: smallestAmount * -1)
            owedMatrix[senderIndex][recipientIndex] = send
            owedMatrix[recipientIndex][senderIndex] = receive
        }
        
        globalOwed = owedMatrix
    }
}

extension MoneyOwed: Equatable {}

func ==(lhs: MoneyOwed, rhs: MoneyOwed) -> Bool {
    return lhs.amount == rhs.amount
    && lhs.sender == rhs.sender
    && lhs.recipient == rhs.recipient
}


extension MoneyOwed: Comparable {}
func <(lhs: MoneyOwed, rhs: MoneyOwed) -> Bool { return lhs.amount < rhs.amount }
func <=(lhs: MoneyOwed, rhs: MoneyOwed) -> Bool { return lhs.amount <= rhs.amount }
func >=(lhs: MoneyOwed, rhs: MoneyOwed) -> Bool { return lhs.amount >= rhs.amount }
func >(lhs: MoneyOwed, rhs: MoneyOwed) -> Bool { return lhs.amount > rhs.amount }
