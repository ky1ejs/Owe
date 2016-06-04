//
//  AddPersonVC.swift
//  IOU
//
//  Created by Kyle McAlpine on 01/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class AddPersonVC: UIViewController, MOCUser {
    @IBOutlet var nameTextField: UITextField!
    
    @IBAction func save() {
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.moc)!
        let person = NSManagedObject(entity: entity, insertIntoManagedObjectContext: self.moc)
        person.setValue(self.nameTextField.text, forKey: "name")
        _ = try? self.moc.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}