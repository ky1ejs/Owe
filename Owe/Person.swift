//
//  Person.swift
//  Owe
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData


class Person: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var expenses: NSSet?
    @NSManaged var colorData: NSData?
    var color: UIColor? {
        get {
            guard let colorData = self.colorData else { return nil }
            return NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        set {
            guard let newValue = newValue else {
                self.colorData = nil
                return
            }
            let colorData = NSKeyedArchiver.archivedDataWithRootObject(newValue)
            self.colorData = colorData
        }
    }
}
