//
//  ErrorAlertView.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/15/21.
//

import SwiftUI


/// Error Alert View.
///
/// - Properties
///     -  error: The `Error` to be displayed in the`ErrorAlertView`.
///     -  carListView: The `CarListView` that contains the`ErrorAlertView`.
///
struct ErrorAlertView: View {
    
    var error: Error
    
    var carListView: CarListView
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -25) {
            Text("ERROR:")
                .font(Font.custom("Menlo", size: 35))
                .fontWeight(.bold)
                .padding()
            Text(error.localizedDescription)
                .font(Font.custom("Menlo", size: 20))
                .multilineTextAlignment(.center)
                .padding()
        }
        .background(Color.init(white: 0.9, opacity: 0.8))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.red, lineWidth: 4)
        )
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
                    /// Set `FetchCars.error` to `nil` to simulate the page reloading without an error.
                    self.carListView.fetch.error = nil
                    
                    /// Set `FetchCars.endpointType` to `.normal` to simulate the page reloading without an empty Array of `Car`.
                    self.carListView.fetch.endpointType = .normal
                    
                    /// Refresh Car List.
                    self.carListView.fetch.forceFetch()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
        .padding()
    }
    
}
