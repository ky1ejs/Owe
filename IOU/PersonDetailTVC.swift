//
//  PersonDetailTVC.swift
//  IOU
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit

class PersonDetailTVC: UITableViewController {
    var person: Person!
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let expenses = self.person.expenses?.allObjects as? [Expense] else { return }
        self.expenses = expenses
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.expenses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.basicCell)!
        switch indexPath.section {
        case 0:     cell.textLabel?.text = self.person.name
        case 1:     cell.textLabel?.text = self.expenses[indexPath.row].title
        default:    break
        }
        return cell
    }
}
