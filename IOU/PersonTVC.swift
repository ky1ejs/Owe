//
//  ViewController.swift
//  IOU
//
//  Created by Kyle McAlpine on 01/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class PersonTVC: UITableViewController, MOCUser, NSFetchedResultsControllerDelegate {
    lazy var fetchController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Person")
        let sortDesc = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDesc]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.moc, sectionNameKeyPath: nil, cacheName: nil)
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
        let ident = "Cell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(ident) ?? UITableViewCell(style: .Default, reuseIdentifier: ident)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let person = self.fetchController.fetchedObjects?[indexPath.row]
        cell.textLabel?.text = person?.valueForKey("name") as? String
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
}

