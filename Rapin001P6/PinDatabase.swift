//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import Foundation
import UIKit

class PinDatabase{
    // create only one instance
    static let sharedInstance = PinDatabase()
    
    // database
    var lastPin: String
    var pinIndex: [String]!
    var pairDatabase: [String : URL]!
    
    private init() {
        lastPin = String()
        pairDatabase = [:]
        pinIndex = []
        
        pinIndex.append("0000")
        pairDatabase["0000"] = URL(string: "https://www.apple.com")
        
        pinIndex.append("0001")
        pairDatabase["0001"] = URL(string: "https://www.google.com")
        
        pinIndex.append("0002")
        pairDatabase["0002"] = URL(string: "https://www.yahoo.com")
        
    }
    
    //add function to add item to the DB
    @discardableResult func addPair(pin: String!, url: URL!) -> Int {
        // add to dictionry
        pairDatabase[pin] = url
        
        //add pin to collection for table view
        pinIndex.append(pin)
        let newIndex = pinIndex.index(of: pin)!
        return newIndex
    }
    
    //add function to delete item
    func deletePair(index: Int) -> () {
        let pin = pinIndex[index]
        
        pairDatabase.removeValue(forKey: pin)
        
        pinIndex.remove(at: index)
    }
    
    //add function to move item
    func movePair(indexFrom: Int, indexTo: Int) -> () {
        let temp = pinIndex[indexFrom]
        pinIndex.remove(at: indexFrom)
        pinIndex.insert(temp, at: indexTo)
    }
    
    //add function to load URL
    func returnURLRequest(pin: String) -> URLRequest? {
        // find url from db
        let url = pairDatabase[pin]
        //create url request
        let request = URLRequest(url: url!)
        //segue to BrowserViewController
        return request
    }
    
    
}
