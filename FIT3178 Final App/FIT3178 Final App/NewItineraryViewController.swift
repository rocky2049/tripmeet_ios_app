//
//  NewItineraryViewController.swift
//  FIT3178 Final App
//
//  Created by Laoqi He on 12/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit

class NewItineraryViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func createItinerary(_ sender: Any) {
        let name = nameTextField.text!
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        let itinerary = Itinerary(name: name, activities: [])
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
