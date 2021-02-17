//
//  FetchCars.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/10/21.
//

import Foundation

///An observable object class that announces changes to the car list, loading status, and any errors.
class FetchCars: ObservableObject {
    
    //MARK: Properties
    
    /// Retrieves the list of cars.
    @Published var cars = [Car]()
    
    /// Indicates whether the data task is currently fetching car data.
    @Published var loading: Bool = false
    
    /// Retrieves the error.
    @Published var error: Error?
    
    var dataTask: URLSessionDataTask?
    
    /// Debug value. If true it adds a 2 second delay when data task completes to allow the loading animation to play.
    let testLoading: Bool = false
    
    /// Endpoint to pull the list of cars from.
    ///
    /// - Important: You must set this to the endpoint type you would like to pull data from.
    ///
    var endpointType: EndpointType = .normal
     
    //MARK: Initialization
    init() {
        forceFetch()
    }
    
    /// Calling this method fetchs the  list of cars.
    func forceFetch() {
        fetchCarList(endpointType.url)
    }
    
    /// Fetchs a list of cars from the given url and updates `cars`.
    ///
    /// - Parameters:
    ///    - url: The URL to retrieve the car list from.
    ///
    func fetchCarList(_ url: URL) {
        
        /// Set `loading` to true to trigger 'Loading Cars...' animation
        loading = true
        
        //Cancel data task if it exists so we can reuse the data task object for a new query
        dataTask?.cancel()
        
        //Initialize a URLSessionDataTask with the url and a completion handler to call when the data task completes
        dataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
            defer {
                self.dataTask = nil
            }
            do {
                //Check if car data exists
                if let carData = data {
                    
                    //Creates a list of cars from JSON data
                    let decodedCarData = try JSONDecoder().decode([Car].self, from: carData)
                    
                    /// Set  `cars` to the returned car list and `loading` to false stop the 'Loading Cars...' animation
                    /// If `testLoading` is  true, add a 2 second delay when data task completes to allow the loading animation to play.
                    if self.testLoading {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.loading = false
                            self.cars = decodedCarData
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.loading = false
                            self.cars = decodedCarData
                        }
                    }
                } else {
                    /// If car data does not exist, set `loading` to false stop the 'Loading Cars...' animation
                    DispatchQueue.main.async {
                        self.loading = false
                    }
                }
            } catch {
                /// Set  `error` to the returned Error and `loading` to false stop the 'Loading Cars...' animation
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = error
                }
            }
        }
        
        //Start the data task
        dataTask?.resume()
    }
    
    /// Endpoint type.
    ///
    /// Type corresponds to one of three possible endpoints for testing car data.
    enum EndpointType: String {
        
        /// Endpoint for car data
        case normal = "https://afterpay-mobile-interview.s3.amazonaws.com/cars.json"
        
        /// Endpoint for empty car data
        case empty = "https://afterpay-mobile-interview.s3.amazonaws.com/cars_empty.json"
        
        /// Endpoint for error in car data
        case error = "https://afterpay-mobile-interview.s3.amazonaws.com/cars_error.json"
        
        /// URL for the endpoint
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
