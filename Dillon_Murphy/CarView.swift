//
//  CarView.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/11/21.
//

import SwiftUI

/// Car Detail View.
///
/// - Properties
///     -  car: The `Car` to display in the `CarView`.
///
struct CarView: View {
    
    var car: Car
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0){
                RemoteImage(url: car.imageString)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fill)
                Text("Vehicle Info").font(.title).frame(maxWidth: .infinity).background(Color.init(white: 0.8, opacity: 0.8))
                VehicleInfoView(car: car)
                Text("Configuration").font(.title2).frame(maxWidth: .infinity).background(Color.init(white: 0.8, opacity: 0.8))
                ConfigurationView(car: car)
                Spacer()
            }
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("\(car.make.manufacturer) \(car.make.model)").font(.title)
                    }
                }
            }
        }
    }
}

struct CarView_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car(make: Make(manufacturer: "Honda", model: "Civic"), color: "Red", year: 2019, configuration: Configuration(body: "Saloon", cylinders: 4, horsepower: 130), origin: "Japan", mpg: 19, image: "images/honda_civic_1.jpg", price: 17500)
        CarView(car: car)
    }
}

/// Car Vehicle Info View.
///
/// - Properties
///     -  car: The `Car` to display in the `VehicleInfoView`.
///
struct VehicleInfoView: View {
    
    var car: Car
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Year:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                }
                Spacer()
                let year = "\(car.year)".replacingOccurrences(of: ",", with: "")
                Text(year).padding([.trailing], 5)
            }
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Price:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                }
                Spacer()
                Text("$\(car.price)").padding([.trailing], 5)
            }.background(Color.init(white: 0.9, opacity: 0.8))
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Exterior Color:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                }
                Spacer()
                Text(car.color).padding([.trailing], 5)
            }
            if let origin = car.origin, let mpg = car.mpg {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Origin:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text(origin).padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
                HStack(alignment: .center, spacing: 0) {
                    //Image("gas").frame(width: 20, height: 20, alignment: .center).padding()
                    VStack(alignment: .leading) {
                        Text("MPG:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(mpg)").padding([.trailing], 5)
                }
            } else if let origin = car.origin {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Origin:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text(origin).padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
            } else if let mpg = car.mpg {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("MPG:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(mpg)").padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
            }
        }
    }
}

/// Car Configuration View.
///
/// - Properties
///     -  car: The `Car` to display in the `ConfigurationView`.
///
struct ConfigurationView: View {
    
    var car: Car
    
    var body: some View {
        VStack(spacing: 5){
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Body:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                }
                Spacer()
                Text("\(car.configuration.body)").padding([.trailing], 5)
            }.background(Color.init(white: 0.9, opacity: 0.8))
            if let cylinders = car.configuration.cylinders, let horsepower = car.configuration.horsepower {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Cylinders:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(cylinders)").padding([.trailing], 5)
                }
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Horsepower:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(horsepower)").padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
            } else if let cylinders = car.configuration.cylinders {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Cylinders:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(cylinders)").padding([.trailing], 5)
                }
            } else if let horsepower = car.configuration.horsepower {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Horsepower:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(horsepower)").padding([.trailing], 5)
                }
            }
            Spacer()
        }
    }
}
