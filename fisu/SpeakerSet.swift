//
//  SpeakerSet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 10/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SpeakerSet {
    
    private var moc : NSManagedObjectContext
    
    init() {
        self.moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    // MARK: - Add, Save & Delete
    
    /// Creation of a new Speaker
    /// - Parameter name: Name of the Speaker
    /// - Parameter surname: Surname of the Speaker
    /// - Parameter abstract: Abstract of the Speaker
    /// - Parameter photo: Photo of the Speaker
    /// - Parameter age: Age of the Speaker
    /// - Parameter email: Email of the Speaker
    /// - Parameter phone: Phone of the Speaker
    /// - returns: Speaker
    func newSpeaker(name : String, surname : String, abstract : String, photo : NSData, age: String, email: String, phone: String) -> Speaker? {
        guard !name.isEmpty || !surname.isEmpty || !abstract.isEmpty || !age.isEmpty || !email.isEmpty || !phone.isEmpty else {
            return nil
        }
        let fr : NSFetchRequest
        fr = NSFetchRequest(entityName: "Speakers")
        let pr : NSPredicate = NSPredicate(format: "name==%@", name)
        fr.predicate = pr
        let result : [Speaker]
        do {
            result = try self.moc.executeFetchRequest(fr) as! [Speaker]
            // If we already have this element in the database, we just give the element in the database instead of insert it again
            if result.count > 0{
                return result[0]
            }
            else {
                let speak = NSEntityDescription.insertNewObjectForEntityForName("Speakers", inManagedObjectContext: self.moc) as! Speaker
                speak.pname = name
                speak.psurname = surname
                speak.pabstract = abstract
                speak.page = age
                speak.pemail = email
                speak.pphone = phone
                speak.pphoto = photo
                
                return speak
            }
        }
        catch{
            return nil
        }
    }
    
    /// Save the Speaker on the coredata
    func saveOnCoreData() {
        do {
            try self.moc.save()
        }
        catch {
            print("Save for the Speaker doesn't work")
        }
    }
    
    /// Delete the Speaker on the coredata
    /// - Parameter speaker: The speaker to be deleted
    func deleteSpeaker(speaker : Speaker) {
        self.moc.deleteObject(speaker)
        self.saveOnCoreData()
    }
    
}