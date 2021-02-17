//
//  Dillon_MurphyTests.swift
//  Dillon_MurphyTests
//
//  Created by Dillon Murphy on 2/10/21.
//

import XCTest
@testable import Dillon_Murphy

class Dillon_MurphyTests: XCTestCase {
    
    var sut: Car!

    override func setUpWithError() throws {
        super.setUp()
        sut = Car(make: Make(manufacturer: "Honda", model: "Civic"), color: "Red", year: 2019, configuration: Configuration(body: "Saloon", cylinders: 4, horsepower: 130), origin: "Japan", mpg: 19, image: "images/honda_civic_1.jpg", price: 17500)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testMakeModelIsComputedProperly() {
      XCTAssertEqual(sut.makeModel, "Honda Civic", "makeModel computed from the make.manufacturer and make.model is wrong")
    }
    
    func testYearMakeModelIsComputedProperly() {
      XCTAssertEqual(sut.yearMakeModel, "2019 Honda Civic", "yearMakeModel computed from the year, make.manufacturer, and make.model is wrong")
    }
    
    func testSearchStringIsComputedProperly() {
      XCTAssertEqual(sut.searchString, "2019 Honda Civic Saloon", "searchString computed from year, make.manufacturer, make.model, and configuration.body is wrong")
    }
    
    func testYearStringIsComputedProperly() {
      XCTAssertEqual(sut.yearString, "2019", "yearString computed from year is wrong")
    }
    
    func testImageStringIsComputedProperly() {
      XCTAssertEqual(sut.imageString, "https://afterpay-mobile-interview.s3.amazonaws.com/images/honda_civic_1.jpg", "imageString computed from relative path is wrong")
    }
    
    func testEngineStringIsComputedProperly() {
      XCTAssertEqual(sut.engineString, "4 Cyl 130HP", "engineString computed from the engine configuration is wrong")
    }

}
