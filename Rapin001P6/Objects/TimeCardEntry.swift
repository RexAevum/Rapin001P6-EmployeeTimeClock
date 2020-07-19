//
//  TimeCardEntry.swift
//  Rapin001P6
//
//  Created by Rolans Apinis on 7/17/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import Foundation

class TimeCardEntry: NSObject{
    var userPin: String
    var clockIn: Date
    var clockOut: Date? = nil
    var isClockedIn = false
    
    init(pin: String, inTime: Date, outTime: Date?) {
        self.userPin = pin
        self.clockIn = inTime
        self.clockOut = outTime
        
        if outTime == nil{
            self.isClockedIn = true
        }
        else{
            self.isClockedIn = false
        }
    }
    //MARK:- Func
    /*!
     Returns a new instance of with only a clock in time
 */
    func clockInPunch(pin: String, inTime: Date) -> TimeCardEntry {
        isClockedIn = true
        return TimeCardEntry(pin: pin, inTime: inTime, outTime: nil)
    }
    
    //updates the clock out time
    func clockOutPunch(punch: TimeCardEntry, timeOut: Date) -> TimeCardEntry {
        let pin = punch.userPin
        let clockInTime = punch.clockIn
        isClockedIn = false
        return TimeCardEntry(pin: pin, inTime: clockInTime, outTime: timeOut)
    }
    
}
