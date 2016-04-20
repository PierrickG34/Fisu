//
//  testLocationSet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 24/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import XCTest
@testable import fisu

class testLocationSet: XCTestCase {

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
    
    func testLocationSetCreation() {
        /*Creation Location*/
        let factoryLocation = LocationSet()
        let locationStart = factoryLocation.newLocation("Name locationStart", latitude: 30.00, longitude: 31.00, isRestaurant: false)
        XCTAssertNotNil(locationStart)
    }
    
    func testLocationSetDelete() {
        /*Creation Location*/
        let factoryLocation = LocationSet()
        let location = factoryLocation.newLocation("Name locationStart", latitude: 30.00, longitude: 31.00, isRestaurant: false)
        XCTAssertNotNil(location)
        
        /*Delete the Location*/
        XCTAssertNotNil(location?.name)
        factoryLocation.deleteLocation(location!)
        XCTAssertNil(location?.name)
    }

}
