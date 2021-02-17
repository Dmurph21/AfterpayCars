//
//  Car.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/10/21.
//

import Foundation

/// Data Model for Car.
struct Car: Codable, Hashable {
    
    /// The make of the car.
    var make: Make
    
    /// The color of the car.
    var color: String
    
    /// The year the car was made.
    var year: Int
    
    /// The configuration of the car.
    var configuration: Configuration
    
    /// The car's country of origin.
    var origin: String?
    
    /// The miles per gallon of the car.
    var mpg: Int?
    
    /// A String that contains the relative path of the image's url.
    var image: String?
    
    /// The price of the car.
    var price: Int
    
    /// Retrieves String containing the car make's `manufacturer` and `model`.
    ///
    /// Concatenates the car's `make` into a single string separated by space.
    ///
    /// - Returns: String containing the car make's `manufacturer` and `model`.
    ///
    var makeModel: String {
        return "\(make.manufacturer) \(make.model)"
    }
    
    /// Retrieves String containing the car's `year` and `make`.
    ///
    /// Concatenates the car's `year` and `make` into a single string separated by spaces.
    ///
    /// - Returns: String containing the car's `year` and `make`.
    ///
    var yearMakeModel: String {
        return "\(yearString) \(makeModel)"
    }
    
    /// Retrieves String containing the car's `year`, `make`, and `body`.
    ///
    /// Concatenates the car's `year`, `make`, and `body` into a single string separated by spaces.
    ///
    /// - Returns: searchable String for the car.
    ///
    var searchString: String {
        return "\(yearString) \(makeModel) \(configuration.body)"
    }
    
    /// Retrieves String containing the car's `year.`
    ///
    /// Removes the comma from the car's `year`.
    ///
    /// - Returns: String containing the `year` the car was made.
    ///
    var yearString: String {
        return "\(year)".replacingOccurrences(of: ",", with: "")
    }
    
    /// Retrieves url string for the car's `image`.
    ///
    /// Concatenates the relative path of the car's `image` to the afterpay image baseURL string.
    ///
    /// - Returns: String containing the url string for the car's `image`.
    ///
    var imageString: String {
        return "https://afterpay-mobile-interview.s3.amazonaws.com/\(image ?? "")"
    }
    
    /// Retrieves optional String containing the car's engine configuration.
    ///
    /// Concatenates the relative path of the car's `configuration.cylinders` to the `configuration.horsepower`.
    ///
    /// - Returns: optional String containing the car's engine configuration.
    ///
    var engineString: String? {
        if let cylinders = configuration.cylinders, let hp = configuration.horsepower {
            return "\(cylinders) Cyl \(hp)HP"
        } else if let cylinders = configuration.cylinders {
            return "\(cylinders) Cyl"
        } else if let hp = configuration.horsepower {
            return "\(hp)HP"
        }
        return nil
    }
    
}

/// The make of the car.
struct Make: Codable, Hashable {
    
    /// The manufacturer of the car.
    let manufacturer: String
    
    /// The model of the car.
    let model: String
    
}

/// The configuration of the car.
struct Configuration: Codable, Hashable {
    
    /// The body type of the car.
    let body: String
    
    /// The number of cylinders in the car's engine.
    let cylinders: Int?
    
    /// The horsepower of the car's engine.
    let horsepower: Int?
}

/*extension Car: Identifiable {
    
    /// Conforms Car to the Identifiable protocol
    var id: UUID { return UUID() }
}*/
