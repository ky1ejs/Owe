//
//  SelectPersonTVC.swift
//  IOU
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

protocol SelectPersonTVCDelegate: class {
    func personSelected(person: Person)
}

class SelectPersonTVC: UITableViewController, MOCUser {
    lazy var people: [Person] = {
        let fetch = NSFetchRequest(entityName: "Person")
        fetch.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let people = try self.moc.executeFetchRequest(fetch)
            return people as? [Person] ?? [Person]()
        } catch {
            abort()
        }
    }()
    private var selectedIndex: NSIndexPath?
    weak var delegate: SelectPersonTVCDelegate?
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.basicCell)!
        cell.textLabel?.text = self.people[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let previouslySelectedIndex = self.selectedIndex {
            let cell = self.tableView.cellForRowAtIndexPath(previouslySelectedIndex)
            cell?.accessoryType = .None
        }
        self.selectedIndex = indexPath
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.personSelected(self.people[indexPath.row])
    }
}
