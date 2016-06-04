//
//  Person.swift
//  IOU
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import Foundation
import CoreData


class Person: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var expenses: NSSet?
}
