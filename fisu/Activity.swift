//
//  Activity.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 03/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Activity)
class Activity : NSManagedObject {
    
    /// Getter and Setter for the **name** of the *Activity* class.
    var pname : String? {
        get {
            return self.name
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.name = nil
                return
            }
            self.name = newValue
        }
    }
    
    /// Getter and Setter for the **detail** of the *Activity* class.
    var pdetail : String? {
        get {
            return self.description
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.detail = nil
                return
            }
            self.detail = newValue
        }
    }
    
    /// Getter and Setter for the **date** of the *Activity* class.
    var pdate : NSDate? {
        get {
            return self.date
        }
        set {
            if let myTest = newValue {
                self.date = myTest
            }
            else {
                return
            }
        }
    }
    
    /// Getter and Setter for the **type** of the *Activity* class.
    var ptype : String? {
        get {
            return self.type
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.type = nil
                return
            }
            self.type = newValue
        }
    }
    
    /// Getter and Setter for the **image** of the *Activity* class.
    var pimage : NSData? {
        get {
            return self.image
        }
        set {
            if let myTest = newValue {
                self.image = myTest
            }
            else {
                return
            }
        }
    }
    
    /// Getter and Setter for the **place** of the *Activity* class.
    var pplace : Location? {
        get {
            return self.located
        }
        set {
            if let myTest = newValue {
                self.located = myTest
            }
            else {
                return
            }
            
        }
    }
    
    /// Getter and Setter for the **surbscribe** of the *Activity* class.
    var psubscribe : NSNumber? {
        get {
            return self.subscribe
        }
        set {
            self.subscribe = newValue
        }
    }
    
    /// Getter for the **presented** of the *Activity* class.
    var ppresented : NSSet? {
        get {
            return self.presented
        }
    }
    
    /// Getter for the **visited** of the *Activity* class.
    var pvisited : NSSet? {
        get {
            return self.visited
        }
    }
    
    /// Getter and Setter for the **datefin** of the *Activity* class.
    var pdatefin : NSDate? {
        get {
            return self.dateFin
        }
        set {
            if let myTest = newValue {
                self.dateFin = myTest
            }
            else {
                return
            }
        }
    }
    
    //MARK: - Functions
    
    /// Add a speaker to an Activity
    /// - Parameter speaker : The speaker to add
    func addSpeaker(speaker: Speaker) {
        self.mutableSetValueForKey("presented").addObject(speaker)
    }
    
    /// Add a visit to an Activity
    /// - Parameter visit : The visit to add
    func addVisit(visit : Visit) {
        self.mutableArrayValueForKey("visited").addObject(visit)
    }
    
    /// Add a location to an Activity
    /// - Parameter location : The location to add
    func addLocation(location: Location) {
        self.mutableArrayValueForKey("located").addObject(location)
    }
}
