//
//  ActivitySet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 03/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ActivitySet {
    
    private var moc : NSManagedObjectContext
    
    init() {
        self.moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    // MARK: - Add, Save & Delete
    
    /// Creation of a new Activity
    /// - Parameter name: Name of the Activity
    /// - Parameter date: Date of the Activity
    /// - Parameter detail: Detail of the Activity
    /// - Parameter typeActivity: Type of the Activity:
    ///     + Conference
    ///     + Visit
    ///     + Sport
    /// - Parameter image: Image of the Activity
    /// - returns: Activity
    func newActivity(name : String, date : NSDate, dateFin : NSDate, detail : String, typeActivity : ActivityEnum, image : NSData) -> Activity? {
        guard !name.isEmpty || !detail.isEmpty else {
            return nil
        }
        let fr : NSFetchRequest
        fr = NSFetchRequest(entityName: "Activities")
        let pr : NSPredicate = NSPredicate(format: "name==%@", name)
        fr.predicate = pr
        let result : [Activity]
        do {
            result = try self.moc.executeFetchRequest(fr) as! [Activity]
            // If we already have this element in the database, we just give the element in the database instead of insert it again
            if result.count > 0 {
                return result[0]
            }
            else {
                let activity = NSEntityDescription.insertNewObjectForEntityForName("Activities", inManagedObjectContext: self.moc) as! Activity
                activity.pname = name
                activity.pdate = date
                activity.dateFin = dateFin
                activity.pdetail = detail
                activity.subscribe = false
                switch(typeActivity) {
                case .Conference:
                    activity.ptype = "Conference"
                case .Show:
                    activity.ptype = "Show"
                case .Sport:
                    activity.ptype = "Sport"
                case .Visit:
                    activity.ptype = "Visit"
                case .Workshop:
                    activity.ptype = "Workshop"
                }
                activity.pimage = image
                return activity
            }
        }
        catch{
            return nil
        }
    }
    
    /// Save the Activity on the coredata
    func saveOnCoreData() {
        do {
            try self.moc.save()
        }
        catch {
            print("Save for the Activity doesn't work")
        }
    }
    
    /// Delete the Activity on the coredata
    /// - Parameter activity: The activity to be deleted
    func deleteActivity(activity : Activity) {
        self.moc.deleteObject(activity)
        self.saveOnCoreData()
    }
    
}