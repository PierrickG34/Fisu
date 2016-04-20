//
//  Speaker.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 09/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData

@objc(Speaker)
class Speaker: NSManagedObject {

    /// Getter and Setter for the **surname** of the *Speaker* class.
    var psurname : String? {
        get {
            return self.surname
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.surname = nil
                return
            }
            self.surname = newValue
        }
    }
    
    /// Getter and Setter for the **name** of the *Speaker* class.
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
    
    /// Getter and Setter for the **abstarct** of the *Speaker* class.
    var pabstract : String? {
        get {
            return self.abstract
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.abstract = nil
                return
            }
            self.abstract = newValue
        }
    }
    
    /// Getter and Setter for the **age** of the *Speaker* class.
    var page : String? {
        get {
            return self.age
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.age = nil
                return
            }
            self.age = newValue
        }
    }
    
    /// Getter and Setter for the **email** of the *Speaker* class.
    var pemail : String? {
        get {
            return self.email
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.email = nil
                return
            }
            self.email = newValue
        }
    }
    
    /// Getter and Setter for the **phone** of the *Speaker* class.
    var pphone : String? {
        get {
            return self.phone
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.phone = nil
                return
            }
            self.phone = newValue
        }
    }
    
    /// Getter for the **activity** of the *Speaker* class.
    var pactivities : NSSet? {
        get {
            return self.activities
        }
    }
    
    /// Getter and Setter for the **photo** of the *Speaker* class.
    var pphoto : NSData? {
        get {
            return self.photo
        }
        set {
            if let myTest = newValue {
                self.photo = myTest
            }
            else {
                return
            }
        }
    }
    
    /// Add an activity to an Speaker
    /// - Parameter activity : The activity to add
    func addActivity(activity: Activity) {
        // Test if the activity in the parameter is a conference before to add
        if (activity.type == ActivityEnum.Conference.rawValue) {
            self.mutableSetValueForKey("activities").addObject(activity)
        }
    }

}
