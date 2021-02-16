//
//  CarCell.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/15/21.
//

import SwiftUI

/// Car List Cell View.
///
/// - Properties
///     -  car: The `Car` to display in the `CarCell`.
///
struct CarCell: View {
    
    var car: Car
    
    var body: some View {
        HStack(spacing: 0) {
            RemoteImage(url: car.imageString)
            VStack(alignment: .leading, spacing: 0) {
                Text(car.yearMakeModel)
                    .underline()
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding([.leading, .top], 5)
                Spacer()
                CarInfoView(car: car)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: 120.0)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .ignoresSafeArea()
    }
}

/// Car List Cell Info View.
///
/// - Properties
///     -  car: The `Car` to display in the `CarInfoView`.
///
struct CarInfoView: View {
    
    var car: Car
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Price:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                }
                Spacer()
                Text("$\(car.price)").padding([.trailing], 5)
            }.background(Color.init(white: 0.9, opacity: 0.8))
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Body:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                }
                Spacer()
                Text("\(car.configuration.body)").padding([.trailing], 5)
            }
            if let cylinders = car.configuration.cylinders, let horsepower = car.configuration.horsepower {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Cylinders:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(cylinders)").padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Horsepower:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(horsepower)").padding([.trailing], 5)
                }
            } else if let cylinders = car.configuration.cylinders {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Cylinders:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(cylinders)").padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
            } else if let horsepower = car.configuration.horsepower {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Horsepower:").alignmentGuide(.leading) { d in d[.trailing] }.padding([.leading], 5)
                    }
                    Spacer()
                    Text("\(horsepower)").padding([.trailing], 5)
                }.background(Color.init(white: 0.9, opacity: 0.8))
            }
            Spacer()
        }
    }
}

struct CarCell_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car(make: Make(manufacturer: "Honda", model: "Civic"), color: "Red", year: 2019, configuration: Configuration(body: "Saloon", cylinders: 4, horsepower: 130), origin: "Japan", mpg: 19, image: "images/honda_civic_1.jpg", price: 17500)
        CarCell(car: car)
    }
}
