//
//  LocationSet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 09/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LocationSet {
    
    private var moc : NSManagedObjectContext
    
    init() {
        self.moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    // MARK: - Add, Save & Delete
    
    /// Creation of a new Location
    /// - Parameter name: Name of the Location
    /// - Parameter latitude: Latitude of the Location
    /// - Parameter longitude: Longitude of the Location
    /// - Parameter activity: Connect the Location to an Activity
    /// - Parameter isRestaurant: Know if it is a restaurant
    /// - returns: Location
    func newLocation(name : String, latitude : NSNumber, longitude : NSNumber, isRestaurant : Bool) -> Location? {
        let fr : NSFetchRequest
        fr = NSFetchRequest(entityName: "Locations")
        let pr : NSPredicate = NSPredicate(format: "name==%@", name)
        fr.predicate = pr
        let result : [Location]
        do {
            result = try self.moc.executeFetchRequest(fr) as! [Location]
            // If we already have this element in the database, we just give the element in the database instead of insert it again
            if result.count > 0 {
                return result[0]
            }
            else {
                let location = NSEntityDescription.insertNewObjectForEntityForName("Locations", inManagedObjectContext: self.moc) as! Location
                location.name = name
                location.latitude = latitude
                location.longitude = longitude
                location.restaurant = isRestaurant
                
                return location
            }
        }
        catch {
            return nil
        }
    }
    
    /// Save the Location on the coredata
    func saveLocationOnCoreData() {
        do {
            try self.moc.save()
        }
        catch {
            print("Save for the Location doesn't work")
        }
    }
    
    /// Delete the Location on the coredata
    /// - Parameter location: The location to be deleted
    func deleteLocation(location : Location) {
        self.moc.deleteObject(location)
        self.saveLocationOnCoreData()
    }
    

}