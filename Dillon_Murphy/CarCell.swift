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
///     -  textSize: CGFloat value representing the size of the font.
///
struct CarCell: View {
    
    var car: Car
    
    var textSize: CGFloat {
        let screenSize = UIScreen.main.bounds.size
        switch screenSize.width {
        case 414,428: return 19
        default: return 17
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            RemoteImage(url: car.imageString)
                .frame(width: 160.0, height: 120.0)
                .aspectRatio(contentMode: .fill)
                .border(Color.black)
            VStack(alignment: .leading, spacing: 0) {
                Text(car.yearMakeModel)
                    .underline()
                    .font(Font.custom("Menlo", size: textSize))
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.5)
                    .frame(maxHeight: 32)
                    .padding([.leading, .trailing, .top], 5)
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
///     -  textSize: CGFloat value representing the size of the font.
///
struct CarInfoView: View {
    
    var car: Car
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Price:")
                        .alignmentGuide(.leading) { d in d[.trailing] }
                        .padding([.leading], 5)
                        .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                }
                Spacer()
                Text("$\(car.price)")
                    .padding([.trailing], 5)
                    .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
            }.background(Color.init(white: 0.9, opacity: 0.8))
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Body:")
                        .alignmentGuide(.leading) { d in d[.trailing] }
                        .padding([.leading], 5)
                        .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                }
                Spacer()
                Text("\(car.configuration.body)")
                    .padding([.trailing], 5)
                    .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
            }
            if let cylinders = car.configuration.cylinders, let horsepower = car.configuration.horsepower {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Cylinders:")
                            .alignmentGuide(.leading) { d in d[.trailing] }
                            .padding([.leading], 5)
                            .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                    }
                    Spacer()
                    Text("\(cylinders)")
                        .padding([.trailing], 5)
                        .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                }.background(Color.init(white: 0.9, opacity: 0.8))
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Horsepower:")
                            .alignmentGuide(.leading) { d in d[.trailing] }
                            .padding([.leading], 5)
                            .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                    }
                    Spacer()
                    Text("\(horsepower)")
                        .padding([.trailing], 5)
                        .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                }
            } else if let cylinders = car.configuration.cylinders {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Cylinders:")
                            .alignmentGuide(.leading) { d in d[.trailing] }
                            .padding([.leading], 5)
                            .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                    }
                    Spacer()
                    Text("\(cylinders)")
                        .padding([.trailing], 5)
                        .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                }.background(Color.init(white: 0.9, opacity: 0.8))
            } else if let horsepower = car.configuration.horsepower {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Horsepower:")
                            .alignmentGuide(.leading) { d in d[.trailing] }
                            .padding([.leading], 5)
                            .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
                    }
                    Spacer()
                    Text("\(horsepower)")
                        .padding([.trailing], 5)
                        .font(Font.custom("Menlo", size: 17))
                        .frame(maxHeight: 20)
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
