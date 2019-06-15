//
//  AddNewActivityViewController.swift
//  FIT3178 Final App
//
//  Created by Laoqi He on 13/06/2019.
//  Copyright © 2019 Laoqi He. All rights reserved.
//

import UIKit

class AddNewActivityViewController: UIViewController {
    
    weak var activityDelegate: AddActivityDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func AddActivity(_ sender: Any) {
        if titleTextField.text != "" && locationTextField.text != "" && datePicker.date <= Date() {
        let name = titleTextField.text!
        let description = descriptionTextView.text!
        let location = locationTextField.text!
        let time = datePicker.date
        let activity = Activity(name: name, desc: description, location: location, time: time)
        
        let _ = activityDelegate!.addActivity(newActivity: activity)
        navigationController?.popViewController(animated: true)
        return
        }
        //validation
        var genericError = "All required fields must be correctly filled to add activity: \n"
        if titleTextField.text == "" {
            genericError += "Please provide a titlex\n"
        }
        if locationTextField.text == "" {
            genericError += "Please provide a location"
        }
        if datePicker.date > Date(){
            genericError += "Please enter a valid date"
        }
        displayMessage(title: "Uncompleted Fields", message: genericError)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //display messages for validation
    func displayMessage(title: String, message: String){
        //Alerts user when there's an error
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
