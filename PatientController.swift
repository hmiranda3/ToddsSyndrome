//
//  PatientController.swift
//  ToddsSyndrome
//
//  Created by Habib Miranda on 10/27/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData

class PatientController {
    
    static let sharedInstance = PatientController()
    
    var fetchedResultsController = NSFetchedResultsController<Patient>()
    
    var patient: Patient?
    
    init() {
        let request = NSFetchRequest<Patient>(entityName: "Patient")
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "name", cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("There was an error performing recommendations fetch request: \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - Functionality
    
    func addPatient(_ name: String, age: Int32, sex: String, migrains: Bool, drugUse: Bool, risk: Double) {
        
        _ = Patient(name: name, age: age, sex: sex, migrains: migrains, drugUse: drugUse, risk: risk)
        
        saveToPersistentStorage()
        
    }
    
    func removePatient(_ patient: Patient) {
        patient.managedObjectContext?.delete(patient)
        saveToPersistentStorage()
    }
    
    func updatePatient(_ patient: Patient, name: String, age: Int32, sex: String, migrains: Bool, drugUse: Bool, risk: Double) {
        
        patient.name = name
        patient.age = age
        patient.sex = sex
        patient.migrains = migrains
        patient.drugUse = drugUse
        patient.risk = risk
        saveToPersistentStorage()
    }
    
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
            print("Success Saving!")
        } catch let error as NSError {
            print("There was an error saving to Managed Object Context. Items not saved: \(error.localizedDescription)")
        }
    }
}

