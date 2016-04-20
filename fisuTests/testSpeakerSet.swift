//
//  testSpeakerSet.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 24/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import XCTest
@testable import fisu

class testSpeakerSet: XCTestCase {

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
    
    func testSpeakerSetCreation() {
        /*Creation speaker*/
        let factorySpeaker = SpeakerSet()
        let speaker = factorySpeaker.newSpeaker("Name", surname: "Surname", abstract: "Abstract", photo: UIImagePNGRepresentation(UIImage(named: "fisu_logo")!)!, age: "age", email: "email@gmail.com", phone: "phone")
        XCTAssertNotNil(speaker)
    }
    
    func testSpeakerSetDelete() {
        /*Creation speaker*/
        let factorySpeaker = SpeakerSet()
        let speaker = factorySpeaker.newSpeaker("Name", surname: "Surname", abstract: "Abstract", photo: UIImagePNGRepresentation(UIImage(named: "fisu_logo")!)!, age: "age", email: "email@gmail.com", phone: "phone")
        XCTAssertNotNil(speaker)

        /*Delete the Speaker*/
        XCTAssertNotNil(speaker?.name)
        factorySpeaker.deleteSpeaker(speaker!)
        XCTAssertNil(speaker?.name)
    }

}
