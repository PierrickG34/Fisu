//
//  Location+CoreDataProperties.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 18/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var restaurant: NSNumber?
    @NSManaged var activity: NSSet?
    @NSManaged var visitEnd: Visit?
    @NSManaged var visitStart: Visit?

}
