//
//  Person.swift
//  Owe
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData


class Person: NSManagedObject, MOCUser {
    @NSManaged var name: String
    @NSManaged var expenses: NSSet?
    @NSManaged var colorData: NSData
    var color: UIColor {
        get {
            return NSKeyedUnarchiver.unarchiveObjectWithData(self.colorData) as! UIColor
        }
        set {
            let colorData = NSKeyedArchiver.archivedDataWithRootObject(newValue)
            self.colorData = colorData
        }
    }
    
    convenience init(name: String) {
        let personEntity = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.dynamicType.moc)!
        
        self.init(entity: personEntity, insertIntoManagedObjectContext: self.dynamicType.moc)
        self.name = name
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        self.color = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
