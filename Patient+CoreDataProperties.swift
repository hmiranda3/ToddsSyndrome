//
//  Patient+CoreDataProperties.swift
//  ToddsSyndrome
//
//  Created by Habib Miranda on 10/27/16.
//  Copyright © 2016 littleJohn's. All rights reserved.
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient");
    }

    @NSManaged public var migrains: Bool
    @NSManaged public var age: Int32
    @NSManaged public var sex: String
    @NSManaged public var drugUse: Bool
    @NSManaged public var name: String
    @NSManaged public var risk: Double

}
