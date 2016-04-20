//
//  Location.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI  on 09/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Location)
class Location: NSManagedObject {

    
    /// Getter and Setter for the **name** of the *Location* class.
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

    /// Getter and Setter for the **latitude** of the *Location* class.
    var platitude : NSNumber? {
        get {
            return self.latitude
        }
        set {
            if let myTest = newValue {
                self.latitude = myTest
            }
            else {
                return
            }
        }
    }
    
    /// Getter and Setter for the **longitude** of the *Location* class.
    var plongitude : NSNumber? {
        get {
            return self.longitude
        }
        set {
            if let myTest = newValue {
                self.longitude = myTest
            }
            else {
                return
            }
        }
    }
    
    /// Getter and Setter for the **restaurant** of the *Location* class.
    var prestaurant : NSNumber? {
        get {
            return self.restaurant
        }
        set {
            self.restaurant = newValue
        }
    }
    
    /// Getter for the **activity** of the *Location* class.
    var pactivity : NSSet? {
        get {
            return self.activity!
        }
    }
    
    /// Getter for the **visitEnd** of the *Location* class.
    var pvisitEnd: Visit? {
        get {
            return self.visitEnd
        }
        
    }
    
    /// Getter for the **visitStart** of the *Location* class.
    var pvisitStart: Visit? {
        get {
            return self.visitStart
        }
    }
    
    /// Add an activity to an Location
    /// - Parameter activity : The activity to add
    func addActivity(activity: Activity) {
        self.mutableSetValueForKey("activity").addObject(activity)
    }

}
