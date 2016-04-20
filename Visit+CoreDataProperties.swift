//
//  Visit+CoreDataProperties.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 15/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Visit {

    @NSManaged var name: String?
    @NSManaged var photo: NSData?
    @NSManaged var timeStart: String?
    @NSManaged var activities: NSSet?
    @NSManaged var start: Location?
    @NSManaged var end: Location?

}
