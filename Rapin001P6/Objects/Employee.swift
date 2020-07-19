//
//  Employee.swift
//  Rapin001P6
//
//  Created by Rolans Apinis on 7/17/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import Foundation

class Employee: NSObject{
    
    var firstName: String!
    var lastName: String!
    var pin: String!
    var timeCards: [TimeCardEntry]
    
    
    init(first: String!, last: String!, pin: String!) {
        self.firstName = first
        self.lastName = last
        self.pin = pin
        self.timeCards = []
        
    }
    convenience override init() {
        self.init(first: "Add First Name", last: "Add Last Name", pin: "Add 4 Digit PIN Number")
    }
    
    
    
}
