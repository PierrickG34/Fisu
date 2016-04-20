//
//  Activity+CoreDataProperties.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 26/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Activity {

    @NSManaged var date: NSDate?
    @NSManaged var detail: String?
    @NSManaged var image: NSData?
    @NSManaged var name: String?
    @NSManaged var subscribe: NSNumber?
    @NSManaged var type: String?
    @NSManaged var dateFin: NSDate?
    @NSManaged var located: Location?
    @NSManaged var presented: NSSet?
    @NSManaged var visited: NSSet?

}
