//
//  CarsView.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/16/21.
//

import SwiftUI

/// Car List View.
///
/// - Properties
///     -  carListView: The `CarListView` that contains the`CarsView`.
///
struct CarsView: View {
    
    var carListView: CarListView
    
    var body: some View {
        List(carListView.carList.filter {
            carListView.searchBar.text.isEmpty || $0.searchString.localizedStandardContains(carListView.searchBar.text)
        }, id: \.self) { car in
            CarCell(car: car)
            // Adding Car Detail View as Destination View
            // Edited out to keep as a single-screen app.
            /*NavigationLink(destination: CarView(car: car)) {
                CarCell(car: car)
            }*/
        }
        .pullToRefresh(isShowing: carListView.$isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.carListView.isShowing = false
                self.carListView.fetch.forceFetch()
            }
        }
        .onChange(of: carListView.isShowing) { value in }
        .padding([.leading,.trailing], -15.0)
        .navigationTitle("Cars")
        .add(carListView.searchBar)
        .ignoresSafeArea()
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Image("AfterpayCar")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Picker("Sorting Options", selection: carListView.$sort) {
                        Text("Make/Model A → Z").tag(0)
                        Text("Make/Model Z → A").tag(1)
                        Text("Year ↓").tag(2)
                        Text("Year ↑").tag(3)
                        Text("Price ↓").tag(4)
                        Text("Price ↑").tag(5)
                    }
                }
                label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
        }
    }
}

struct CarsView_Previews: PreviewProvider {
    static var previews: some View {
        CarsView(carListView: CarListView())
    }
}
