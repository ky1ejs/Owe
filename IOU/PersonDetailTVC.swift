//
//  PersonDetailTVC.swift
//  IOU
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class PersonDetailTVC: UITableViewController, MOCUser {
    var person: Person!
    var owed = [Owed]()
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let expenses = self.person.expenses?.allObjects as? [Expense] {
            self.expenses = expenses
        }
        
        
        do {
            try Owed.recalculate()
            self.owed = try Owed.forPerson(self.person)
        } catch {}
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:     return 1
        case 1:     return self.owed.count
        case 2:     return self.expenses.count
        default:    return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.basicCell)!
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = self.person.name
        case 1:
            let owedForRow = self.owed[indexPath.row]
            cell.textLabel?.text = owedForRow.sender.name
            cell.detailTextLabel?.text = String(owedForRow.amount)
        case 2:
            cell.textLabel?.text = self.expenses[indexPath.row].title
        default:
            break
        }
        return cell
    }
}
