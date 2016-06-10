//
//  ViewController.swift
//  Owe
//
//  Created by Kyle McAlpine on 01/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class PersonsTVC: UITableViewController, MOCUser, NSFetchedResultsControllerDelegate {
    lazy var fetchController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Person")
        let sortDesc = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDesc]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.dynamicType.moc, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        _ = try? self.fetchController.performFetch()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.basicCell)!
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let person = self.fetchController.fetchedObjects?[indexPath.row] as? Person
        cell.textLabel?.text = person?.name
        cell.backgroundColor = person?.color
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        let sectionIndexSet = NSIndexSet(index: sectionIndex)
        switch type {
        case .Insert:
            self.tableView.insertSections(sectionIndexSet, withRowAnimation: .Automatic)
        case .Delete:
            self.tableView.deleteSections(sectionIndexSet, withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            guard let newIndexPath = newIndexPath else { return }
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Delete:
            guard let indexPath = indexPath else { return }
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else { return }
            guard let cell = self.tableView.cellForRowAtIndexPath(indexPath) else { return }
            self.configureCell(cell, atIndexPath: indexPath)
        case .Move:
            guard let indexPath = indexPath else { return }
            guard let newIndexPath = newIndexPath else { return }
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let personDetailTVC = R.segue.personsTVC.showPerson(segue: segue) else { return }
        guard let selectedIndex = self.tableView.indexPathForSelectedRow else { return }
        guard let person = self.fetchController.fetchedObjects?[selectedIndex.row] as? Person else { return }
        personDetailTVC.destinationViewController.person = person
    }
}

