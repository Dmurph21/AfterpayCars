//
//  Dillon_MurphyTests.swift
//  Dillon_MurphyTests
//
//  Created by Dillon Murphy on 2/10/21.
//

import XCTest
@testable import Dillon_Murphy

class Dillon_MurphyTests: XCTestCase {
    
    var sut: CarListView!
    var carList: [Car] = [Car]()

    override func setUpWithError() throws {
        super.setUp()
        sut = CarListView()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        carList = [Car]()
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCarsNotEmpty() throws {
        let promise = expectation(description: "Status code: 200")
        carList = sut.fetch.cars
        let carsEmpty = carList.count > 0
        if carsEmpty {
            promise.fulfill()
        } else {
            
        }
        //wait(for: [promise], timeout: 15)
        //print("Cars Empty: \(carsEmpty)")
        //XCTAssertTrue(true, "Cars list is empty.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
