//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programming Assignment #5
//  DUE: Thursday 07/12/2020 //

import UIKit

class EditViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let nr = PinDatabase.sharedInstance.pairDatabase.count
        if (nr <= 10){
            return nr
        }
        else{
            return 10
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: Using custom cell
        //!!!!!!!!
        //need to cast as! <name of custom cell class>
        let cell = tableView.dequeueReusableCell(withIdentifier: "link", for: indexPath) as! TableViewCell
        
        let gotPin = PinDatabase.sharedInstance.pinIndex[indexPath.row]
        let url = PinDatabase.sharedInstance.pairDatabase[gotPin]
        
        cell.pinField.text = gotPin
        cell.urlField.text = url?.absoluteString
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // get pin
            let pin = PinDatabase.sharedInstance.pinIndex[indexPath.row]
            PinDatabase.sharedInstance.deletePair(index: indexPath.row)
            print("\(pin) pair is deleted")
            
            // delete the row from the table view!!!
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        PinDatabase.sharedInstance.movePair(indexFrom: fromIndexPath.row, indexTo: to.row)
    }
 

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "addNew"?:
            // pass new pair
            let pin = "----"
            let url = URL(string: "about:blank")
            
            //add to db
            PinDatabase.sharedInstance.pinIndex.append(pin)
            PinDatabase.sharedInstance.addPair(pin: pin, url: url)
            
            // pass data in segue
            let targetView = segue.destination as! DetailEditViewController
            targetView.pin = pin
            targetView.url = url!
            
            print(self)
            break
        case "details"?:
            // pass pair based in the index
            if let index = tableView.indexPathForSelectedRow?.row{
                let pin = PinDatabase.sharedInstance.pinIndex[index]
                let url = PinDatabase.sharedInstance.pairDatabase[pin]
                
                let targetView = segue.destination as! DetailEditViewController
                
                targetView.pin = pin
                targetView.url = url!
            }
          
                
        
            print(self)
        default:
            preconditionFailure("Unknown segue")
        }
    }
 

}
