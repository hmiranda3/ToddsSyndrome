//
//  InterviewTableViewController.swift
//  ToddsSyndrome
//
//  Created by Habib Miranda on 10/27/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit

class InterviewTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    let yesNoArray = ["Yes", "No"]
    let genderArray = ["Male", "Female"]

    //MARK: Interview IB Outlets:
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var migrainsTextField: UITextField!
    @IBOutlet weak var drugsTextField: UITextField!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet var optionPicker: UIPickerView!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton()

        sexTextField.inputView = optionPicker
        migrainsTextField.inputView = optionPicker
        drugsTextField.inputView = optionPicker
        optionPicker.delegate = self
        optionPicker.dataSource = self
        
        self.nameTextField.delegate = self
        self.ageTextField.delegate = self
        self.sexTextField.delegate = self
        self.migrainsTextField.delegate = self
        self.drugsTextField.delegate = self
        
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    // MARK: - optionPicker Functionality
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yesNoArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if sexTextField.isEditing {
            return genderArray[row]
        } else {
            return yesNoArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if drugsTextField.isEditing {
            displayRisk()
            drugsTextField.text = yesNoArray[row]
        } else if migrainsTextField.isEditing {
            displayRisk()
            migrainsTextField.text = yesNoArray[row]
        } else if sexTextField.isEditing {
            displayRisk()
            sexTextField.text = genderArray[row]
        }
    }
    
    func dismissPicker() {
        sexTextField.resignFirstResponder()
        migrainsTextField.resignFirstResponder()
        drugsTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
    }

    func addDoneButton() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        customView.backgroundColor = UIColor.lightGray
    
        let doneButton = UIButton(frame: CGRect(x: customView.frame.width - 55, y: 0, width: 50, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.addTarget(self, action: #selector(dismissPicker), for: .touchUpInside)
        customView.addSubview(doneButton)
        
        sexTextField.inputAccessoryView = customView
        migrainsTextField.inputAccessoryView = customView
        drugsTextField.inputAccessoryView = customView
        ageTextField.inputAccessoryView = customView
    }

    //MARK: Calculating and Displayng Risk
    
//    func calculateRisk() -> Double {
//        var risk: Double = 0.0
//        
//        if let age = Int((ageTextField?.text)!) {
//            if age <= 15 {
//                risk += 25
//            }
//        }
//        
//        if sexTextField.text == "Male" {
//            risk += 25
//        }
//        
//        if migrainsTextField.text == "Yes" {
//            risk += 25
//        }
//        
//        if drugsTextField.text == "Yes" {
//            risk += 25
//        }
//        
//        return risk
//    }
    
    func displayRisk() {
        var risk: Double = 0.0
        
        if let age = Int((ageTextField?.text)!) {
            if age <= 15 {
                risk += 25
            }
        }
        
        if sexTextField.text == "Male" {
            risk += 25
        }
        
        if migrainsTextField.text == "Yes" {
            risk += 25
        }
        
        if drugsTextField.text == "Yes" {
            risk += 25
        }

        riskLabel.text = "\(risk)%"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        displayRisk()
    }
    


    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
