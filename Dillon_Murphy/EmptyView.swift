//
//  EmptyView.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/15/21.
//

import SwiftUI

/// Car List Empty View.
///
/// - Properties
///     -  carListView: The `CarListView` that contains the`EmptyView`.
///
struct EmptyView: View {
    
    var carListView: CarListView
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -25) {
            Text("No Cars Found!")
                .font(Font.custom("Menlo", size: 35))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(Color.init(white: 0.5, opacity: 1))
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationTitle("Cars")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Image("AfterpayCar")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    /// Set `FetchCars.endpointType` to `.normal` to simulate the page reloading without an empty Array of `Car`.
                    self.carListView.fetch.endpointType = .normal
                    
                    /// Refresh Car List.
                    self.carListView.fetch.forceFetch()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(carListView: CarListView())
    }
}
