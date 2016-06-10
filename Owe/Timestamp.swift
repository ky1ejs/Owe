//
//  Timestamp.swift
//  Owe
//
//  Created by Kyle McAlpine on 11/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit

private var df: NSDateFormatter = {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm"
    return df
}()

struct Timestamp {
    static func dateFromString(string: String) -> NSDate? {
        return df.dateFromString(string)
    }
    
    static func stringFromDate(date: NSDate) -> String {
        return df.stringFromDate(date)
    }
}
