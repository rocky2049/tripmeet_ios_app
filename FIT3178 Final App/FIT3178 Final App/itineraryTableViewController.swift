//
//  itineraryTableViewController.swift
//  FIT3178 Final App
//
//  Created by Laoqi He  on 12/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit

class itineraryTableViewController: UITableViewController, AddActivityDelegate {
    let SECTION_ACTIVITY = 0;
    let CELL_ACTIVITY = "activityCell"
    var currentItinerary: [Activity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
            let activityCell = tableView.dequeueReusableCell(withIdentifier: CELL_ACTIVITY,
                                                          for: indexPath)
                as! ActivityTableViewCell
            let activity = currentItinerary[indexPath.row]
            
        activityCell.activityLabel.text = activity.name
        var timeString = formatDate(activityDate:activity.time)
        activityCell.descriptionLabel.text = timeString  + activity.location
            
        return activityCell
        }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "AddActivitySegue" {
         let destination = segue.destination as! AddNewActivityViewController
         destination.activityDelegate = self
            }
        }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    //Formatting date values from activity class to string value
    /***************************************************************************************
     *    Title: Date format in swift
     *    Author: LorenzOliveto
     *    Date: 01/10/18 (originally posted 29/02/16)
     *    Date retrieved: 15/06/19
     *    Availability: https://stackoverflow.com/questions/35700281/date-format-in-swift
     *
     ***************************************************************************************/
    func formatDate(activityDate: Date){
     let dateFormatterGet = DateFormatter()
     dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
     let dateString = dateFormatterGet.string(from: activityDate)
     let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mma"
     if let date = dateFormatterGet.date(from: dateString) {
      let newDateString = dateFormatterPrint.string(from: date)
     } else {
      let newDateString = "Error"
     }
      return newDateString
    }
        
    func addActivity(newActivity: Activity) -> Bool {
        currentItinerary.append(newActivity)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: currentItinerary.count - 1, section:1)], with: .automatic)
        tableView.endUpdates()
        return true
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    }
