//
//  Visit.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 14/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Visit)
class Visit: NSManagedObject {
    
    /// Getter and Setter for the **name** of the *Visit* class.
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
    
    /// Getter and Setter for the **photo** of the *Visit* class.
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
    
    /// Getter and Setter for the **timeStart** of the *Visit* class.
    var ptimeStart : String? {
        get {
            return self.timeStart
        }
        set {
            guard let myTest = newValue where !myTest.isEmpty else {
                self.timeStart = nil
                return
            }
            self.name = newValue
        }
    }
    
    /// Getter for the **activity** of the *Visit* class.
    var pactivities : NSSet? {
        get {
            return self.activities
        }
    }
    
    /// Getter and Setter for the **start** of the *Visit* class.
    var pstart : Location? {
        get {
            return self.start
        }
        set {
            if let myTest = newValue {
                self.start = myTest
            }
            else {
                return
            }
            
        }
    }
    
    /// Getter and Setter for the **end** of the *Visit* class.
    var pend : Location? {
        get {
            return self.end
        }
        set {
            if let myTest = newValue {
                self.end = myTest
            }
            else {
                return
            }
            
        }
    }
    
    /// Add an activity to an Visit
    /// - Parameter activity : The activity to add
    func addActivity(activity: Activity) {
        // Test if the activity in the parameter is a visit before to add
        if (activity.type == ActivityEnum.Visit.rawValue) {
            self.mutableSetValueForKey("activities").addObject(activity)
        }
    }
}
