//
//  ViewController.swift
//  Rapin001P6
//
//  Created by Rolans Apinis on 7/16/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

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
        
        return cell
        
        
    }


}

