//
//  Patient+CoreDataClass.swift
//  ToddsSyndrome
//
//  Created by Habib Miranda on 10/27/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData


public class Patient: NSManagedObject {
    
    static let nameKey = "name"
    static let ageKey = "age"
    static let sexKey = "sex"
    static let migrainsKey = "migrains"
    static let drugUseKey = "drugUse"
    static let riskKey = "risk"
    
    convenience init(name: String, age: Int32, sex: String, migrains: Bool, drugUse: Bool, risk: Double, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Patient", in: context) else {
            fatalError("Error initializing Patient.")
        }

        self.init(entity: entity, insertInto: context)

        self.name = name
        self.age = age
        self.sex = sex
        self.migrains = migrains
        self.drugUse = drugUse
        self.risk = risk
        
    }

}
