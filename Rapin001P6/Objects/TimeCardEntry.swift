//
//  TimeCardEntry.swift
//  Rapin001P6
//
//  Created by Rolans Apinis on 7/17/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import Foundation

class TimeCardEntry: NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userPin, forKey: "userPin")
        aCoder.encode(clockIn, forKey: "clockIn")
        aCoder.encode(clockOut, forKey: "clockOut")
        aCoder.encode(isClockedIn, forKey: "isClockedIn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        userPin = aDecoder.decodeObject(forKey: "userPin") as! String
        clockIn = aDecoder.decodeObject(forKey: "clockIn") as! Date
        clockOut = aDecoder.decodeObject(forKey: "clockOut") as? Date
        isClockedIn = aDecoder.decodeObject(forKey: "isClockedIn") as? Bool
    }
    
    var userPin: String
    var clockIn: Date
    var clockOut: Date? = nil
    var isClockedIn: Bool?
    
    init(pin: String, inTime: Date, outTime: Date?, clockedIn: Bool?) {
        self.userPin = pin
        self.clockIn = inTime
        self.clockOut = outTime
        
        if clockedIn == nil{
            if outTime == nil{
                self.isClockedIn = true
            }
            else{
                self.isClockedIn = false
            }
        }
        else{
            self.isClockedIn = clockedIn!
        }
    }
    //MARK:- Func
    /*!
     Returns a new instance of with only a clock in time
 */
    func clockInPunch(pin: String, inTime: Date) -> TimeCardEntry {
        self.isClockedIn = true
        return TimeCardEntry(pin: pin, inTime: inTime, outTime: nil, clockedIn: true)
    }
    
    //updates the clock out time
    func clockOutPunch(punch: TimeCardEntry, timeOut: Date) -> TimeCardEntry {
        let pin = punch.userPin
        let clockInTime = punch.clockIn
        self.isClockedIn = false
        return TimeCardEntry(pin: pin, inTime: clockInTime, outTime: timeOut, clockedIn: false)
    }
    
}
