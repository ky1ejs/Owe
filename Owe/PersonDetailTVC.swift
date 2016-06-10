//
//  PersonDetailTVC.swift
//  Owe
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class PersonDetailTVC: UITableViewController, MOCUser {
    var person: Person!
    var owe = [MoneyOwed]()
    var owed = [MoneyOwed]()
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let expenses = self.person.expenses?.allObjects as? [Expense] {
            self.expenses = expenses
        }
        
        do {
            try MoneyOwed.recalculate()
            let owed = try MoneyOwed.forPerson(self.person)
            self.owe = owed.filter() { $0.amount > 0 }
            self.owed = owed.filter() { $0.amount < 0 }
        } catch {}
        
        self.title = self.person.name
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:     return self.owe.count > 0 ? self.owe.count : 1
        case 1:     return self.owed.count > 0 ? self.owed.count : 1
        case 2:     return self.expenses.count > 0 ? self.expenses.count : 1
        default:    return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.basicCell)!
        cell.backgroundColor = .whiteColor()
        switch indexPath.section {
        case 0, 1:
            let arrayForRow = indexPath.section == 1 ? self.owe : self.owed
            if arrayForRow.count > 0 {
                let owedForRow = arrayForRow[indexPath.row]
                cell.textLabel?.text = owedForRow.recipient.name
                cell.detailTextLabel?.text = String(abs(owedForRow.amount))
                cell.backgroundColor = owedForRow.recipient.color
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.noneCell)!
            }
        case 2:
            if self.expenses.count > 0 {
                let expenseForRow = self.expenses[indexPath.row]
                cell.textLabel?.text = expenseForRow.title
                cell.detailTextLabel?.text = String(expenseForRow.amount)
            } else {
                cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.noneCell)!
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:     return "Need to send"
        case 1:     return "To be received"
        case 2:     return "Expenses"
        default:    return nil
        }
    }
}
