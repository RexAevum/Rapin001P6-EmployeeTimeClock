//
//  ViewController.swift
//  Rapin001P6
//
//  Created by Rolans Apinis on 7/16/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//
import Foundation
import UIKit

class TimeLogViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PinDatabase.sharedInstance.timeCardDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCard") as! TimeCardCell
        
        // need to print first / last / in / out
        
        // get time card entry and extract in / out and use pin to find user name
        let count = PinDatabase.sharedInstance.timeCardDB.count
        let entry = PinDatabase.sharedInstance.timeCardDB[count - 1 - indexPath.row]
        
        // get employee info
        let employee = PinDatabase.sharedInstance.pairDatabase[entry.userPin]
        
        //set field
        cell.firstNameField.text = employee?.firstName
        cell.lastNameField.text = employee?.lastName
        cell.clockInTimeField.text = DateFormatter.localizedString(from: entry.clockIn, dateStyle: .none, timeStyle: .short)
        if entry.clockOut != nil {
            cell.clockOutTimeField.text = DateFormatter.localizedString(from: entry.clockOut!, dateStyle: .none, timeStyle: .short)
        }
        else{
            cell.clockOutTimeField.text = "--"
        }
        
        return cell
        
        
    }


}

