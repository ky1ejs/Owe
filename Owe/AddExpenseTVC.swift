//
//  AddExpenseVC.swift
//  Owe
//
//  Created by Kyle McAlpine on 04/06/2016.
//  Copyright © 2016 Kyle McAlpine. All rights reserved.
//

import UIKit
import CoreData

class AddExpenseTVC: UITableViewController, MOCUser, SelectPersonTVCDelegate {
    @IBOutlet private weak var titleTF: UITextField!
    @IBOutlet private weak var descriptionTF: UITextField!
    @IBOutlet private weak var amountTF: UITextField!
    @IBOutlet private weak var personLabel: UILabel!
    private var person: Person?
    
    @IBAction func save() {
        guard let title = self.titleTF.text where title.characters.count > 0 else { return }
        guard let description = self.descriptionTF.text where description.characters.count > 0 else { return }
        guard let amount = self.amountTF.text where amount.characters.count > 0 else { return }
        guard let person = self.person else { return }
        _ = Expense(amount: NSDecimalNumber(string: amount), desc: description, title: title, person: person)
        _ = try? self.dynamicType.moc.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segue = R.segue.addExpenseTVC.selectPerson(segue: segue) else { return }
        segue.destinationViewController.delegate = self
    }
    
    func personSelected(person: Person) {
        self.person = person
        self.personLabel.text = person.name
        self.navigationController?.popViewControllerAnimated(true)
    }
}
