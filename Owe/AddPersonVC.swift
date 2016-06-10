//
//  AddPersonVC.swift
//  Owe
//
//  Created by Kyle McAlpine on 01/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class AddPersonVC: UIViewController, MOCUser {
    @IBOutlet var nameTextField: UITextField!
    
    @IBAction func save() {
        _ = Person(name: self.nameTextField.text!)
        _ = try? self.dynamicType.moc.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
