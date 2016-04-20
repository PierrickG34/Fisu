//
//  testVisitSet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 24/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import XCTest
@testable import fisu

class testVisitSet: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testVisitSetCreation() {
        /*Creation location*/
        let factoryLocation = LocationSet()
        let locationStart = factoryLocation.newLocation("Name locationStart", latitude: 30.00, longitude: 31.00, isRestaurant: false)
        let locationEnd = factoryLocation.newLocation("Name locationEnd", latitude: 32.00, longitude: 33.00, isRestaurant: false)
        XCTAssertNotNil(locationStart)
        XCTAssertNotNil(locationEnd)
        
        
        /*Creation visit*/
        let factoryVisit = VisitSet()
        let visit = factoryVisit.newVisit("Name visit", timeStart: "Time start visit", photo: UIImagePNGRepresentation(UIImage(named: "fisu_logo")!)!, startLocation: locationStart!, endLocation: locationEnd!)
        
        XCTAssertNotNil(visit)
    }
    
    func testVisitSetDelete() {
        /*Creation location*/
        let factoryLocation = LocationSet()
        let locationStart = factoryLocation.newLocation("Name locationStart", latitude: 30.00, longitude: 31.00, isRestaurant: false)
        let locationEnd = factoryLocation.newLocation("Name locationEnd", latitude: 32.00, longitude: 33.00, isRestaurant: false)
        XCTAssertNotNil(locationStart)
        XCTAssertNotNil(locationEnd)
        
        
        /*Creation visit*/
        let factoryVisit = VisitSet()
        let visit = factoryVisit.newVisit("Name visit", timeStart: "Time start visit", photo: UIImagePNGRepresentation(UIImage(named: "fisu_logo")!)!, startLocation: locationStart!, endLocation: locationEnd!)
        XCTAssertNotNil(visit)
        
        /*Delete the Visit*/
        XCTAssertNotNil(visit?.name)
        factoryVisit.deleteVisit(visit!)
        XCTAssertNil(visit?.name)
    }

}
