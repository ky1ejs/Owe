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
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.dynamicType.moc)!
        let person = Person(entity: entity, insertIntoManagedObjectContext: self.dynamicType.moc)
        person.name = self.nameTextField.text
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        person.color = UIColor(red: r, green: g, blue: b, alpha: 1)
        _ = try? self.dynamicType.moc.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
