//
//  FetchCarsTests.swift
//  Dillon_MurphyTests
//
//  Created by Dillon Murphy on 2/11/21.
//

import XCTest
@testable import Dillon_Murphy

class FetchCarsTests: XCTestCase {
    
    var sut: URLSession!

    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToAfterpayGetsHTTPStatusCode200() throws {
      // given
      let url = URL(string: "https://afterpay-mobile-interview.s3.amazonaws.com/cars.json")
      // 1
      let promise = expectation(description: "Status code: 200")
      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }

    func testCarsNotEmpty() throws {
        // given
        let url = URL(string: "https://afterpay-mobile-interview.s3.amazonaws.com/cars.json")
        // 1
        let promise = expectation(description: "Cars list is not empty.")
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          // then
            do {
                if let carData = data {
                    // 3.
                    let carList = try JSONDecoder().decode([Car].self, from: carData)
                    let carsEmpty = carList.count > 0
                    if carsEmpty {
                        promise.fulfill()
                    } else {
                        XCTFail("Cars list is empty.")
                    }
                } else {
                    XCTFail("No data.")
                }
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    func testCarsEmpty() throws {
        // given
        let url = URL(string: "https://afterpay-mobile-interview.s3.amazonaws.com/cars_empty.json")
        // 1
        let promise = expectation(description: "Cars list is empty.")
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          // then
            do {
                if let carData = data {
                    // 3.
                    let carList = try JSONDecoder().decode([Car].self, from: carData)
                    let carsEmpty = carList.count > 0
                    if !carsEmpty {
                        promise.fulfill()
                    } else {
                        XCTFail("Cars list is not empty.")
                    }
                } else {
                    XCTFail("No data.")
                }
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    func testCarsError() throws {
        // given
        let url = URL(string: "https://afterpay-mobile-interview.s3.amazonaws.com/cars_error.json")
        // 1
        let promise = expectation(description: "Error retrieving cars list.")
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          // then
            do {
                if let carData = data {
                    // 3.
                    let carList = try JSONDecoder().decode([Car].self, from: carData)
                    let carsEmpty = carList.count > 0
                    if !carsEmpty {
                        promise.fulfill()
                    } else {
                        XCTFail("Cars list data retrieved.")
                    }
                } else {
                    XCTFail("No data.")
                }
            } catch {
                promise.fulfill()
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceCarsNotEmpty() throws {
        self.measure {
            // given
            let url = URL(string: "https://afterpay-mobile-interview.s3.amazonaws.com/cars.json")
            // 1
            let promise = expectation(description: "Cars list is not empty.")
            // when
            let dataTask = sut.dataTask(with: url!) { data, response, error in
              // then
                do {
                    if let carData = data {
                        // 3.
                        let carList = try JSONDecoder().decode([Car].self, from: carData)
                        let carsEmpty = carList.count > 0
                        if carsEmpty {
                            promise.fulfill()
                        } else {
                            XCTFail("Cars list is empty.")
                        }
                    } else {
                        XCTFail("No data.")
                    }
                } catch {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
            dataTask.resume()
            // 3
            wait(for: [promise], timeout: 5)
        }
    }

}
