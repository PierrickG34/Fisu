//
//  VisitSet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 14/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//


import Foundation
import CoreData
import UIKit

class VisitSet {
    
    private var moc : NSManagedObjectContext
    
    init() {
        self.moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    // MARK: - Add, Save & Delete
    
    /// Creation of a new Visit
    /// - Parameter name: Name of the Visit
    /// - Parameter timeStart: TimeStart of the Visit
    /// - Parameter photo: Photo of the Visit
    /// - Parameter startLocation: StartLocation of the Visit
    /// - Parameter endLocation: EndLocation of the Visit
    /// - returns: Visit
    func newVisit(name : String, timeStart : String, photo: NSData, startLocation : Location, endLocation : Location) -> Visit? {
        guard !name.isEmpty || !timeStart.isEmpty else {
            return nil
        }
        let fr : NSFetchRequest
        fr = NSFetchRequest(entityName: "Visits")
        let pr : NSPredicate = NSPredicate(format: "name==%@", name)
        fr.predicate = pr
        let result : [Visit]
        do {
            result = try self.moc.executeFetchRequest(fr) as! [Visit]
            // If we already have this element in the database, we just give the element in the database instead of insert it again
            if result.count > 0 {
                return result[0]
            }
            else {
                let visit = NSEntityDescription.insertNewObjectForEntityForName("Visits", inManagedObjectContext: self.moc) as! Visit
                visit.name = name
                visit.photo = photo
                visit.timeStart = timeStart
                visit.start = startLocation
                visit.end = endLocation
                
                return visit
            }
        }
        catch {
            return nil
        }
    }
    
    /// Save the Visit on the coredata
    func saveLocationOnCoreData() {
        do {
            try self.moc.save()
        }
        catch {
            print("Save for the Location doesn't work")
        }
    }
    
    /// Delete the Visit on the coredata
    /// - Parameter visit: The visit to be deleted
    func deleteVisit(visit : Visit) {
        self.moc.deleteObject(visit)
        self.saveLocationOnCoreData()
    }
    
    
}