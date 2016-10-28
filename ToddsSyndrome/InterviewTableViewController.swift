//
//  InterviewTableViewController.swift
//  ToddsSyndrome
//
//  Created by Habib Miranda on 10/27/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import UIKit

class InterviewTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate{
    
    let yesNoArray = ["Yes", "No"]
    let genderArray = ["Male", "Female"]
    
    var patient: Patient?

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
        
        if let patient = patient {
            updateWithPatient(patient)
        }
        
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
    
    //Redundant, fix it.
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        emptyTextfieldAlert()
        if patient == nil && nameTextField.text != "" && ageTextField.text != "" && sexTextField.text != "" && migrainsTextField.text != "" && drugsTextField.text != "" {
            emptyTextfieldAlert()
            createPatient()
            _ = navigationController?.popViewController(animated: true)
        } else if nameTextField.text != "" && ageTextField.text != "" && sexTextField.text != "" && migrainsTextField.text != "" && drugsTextField.text != ""  {
            emptyTextfieldAlert()
            updatePatient()
            _ = navigationController?.popViewController(animated: true)
        }

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

        riskLabel.text = "\(risk)"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        displayRisk()
    }
    
    // MARK: - Core Data Functionality
    
    func createPatient() {
        var drugUse: Bool
        var migrains: Bool
        guard let name = nameTextField.text,
            let age = Int32(ageTextField.text!),
            let sex = sexTextField.text,
            let risk = Double(riskLabel.text!) else { return }
        
        if migrainsTextField.text == "True" {
            migrains = true
        } else {
            migrains = false
        }
        if drugsTextField.text == "True" {
            drugUse = true
        } else {
            drugUse = false
        }

        PatientController.sharedInstance.addPatient(name, age: age, sex: sex, migrains: migrains, drugUse: drugUse, risk: risk)
    }
    
    func updatePatient() {
        var drugUse: Bool
        var migrains: Bool
        guard let name = nameTextField.text,
            let age = Int32(ageTextField.text!),
            let sex = sexTextField.text,
            let risk = Double(riskLabel.text!) else { return }
        
        if migrainsTextField.text == "True" {
            migrains = true
        } else {
            migrains = false
        }
        if drugsTextField.text == "True" {
            drugUse = true
        } else {
            drugUse = false
        }
        
        
        if let patient = self.patient {
            PatientController.sharedInstance.updatePatient(patient, name: name, age: age, sex: sex, migrains: migrains, drugUse: drugUse, risk: risk)
        }
       
    }
    
    func updateWithPatient(_ patient: Patient) {
        self.patient = patient
        
        title = patient.name
        nameTextField.text = patient.name
        
        ageTextField.text = "\(patient.age)"
        
        sexTextField.text = patient.sex
        
        if patient.migrains == true {
            migrainsTextField.text = "True"
        } else {
            migrainsTextField.text = "False"
        }
        if patient.drugUse == true {
            drugsTextField.text = "True"
        } else {
            drugsTextField.text = "False"
        }
        
        riskLabel.text = "\(patient.risk)"
        
    }

    func emptyTextfieldAlert() {
        
        if (nameTextField.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "No name entered!"
            alert.message = "Please enter a name."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if (ageTextField.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Please enter an age!"
            alert.message = "In order to evaluate risk, you need to enter an age."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if (sexTextField.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Please indicate gender!"
            alert.message = "Gender is important in order to calculate risk."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if (migrainsTextField.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Migrain info required!"
            alert.message = "Migrains are an important factor in determining risk."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if (drugsTextField.text!.isEmpty) {
            let alert = UIAlertController()
            alert.title = "Does the patient use drugs?"
            alert.message = "Drug use is important in order to calculate risk."
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
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
    

   
}
