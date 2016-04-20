//
//  Speaker+CoreDataProperties.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 14/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Speaker {

    @NSManaged var abstract: String?
    @NSManaged var age: String?
    @NSManaged var email: String?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var photo: NSData?
    @NSManaged var surname: String?
    @NSManaged var activities: NSSet?

}
