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
///     -  contentView: The `ContentView` that contains the`ErrorAlertView`.
///
struct ErrorAlertView: View {
    
    var error: Error
    
    var contentView: ContentView
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -25) {
            Text("ERROR:")
                .fontWeight(.bold)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding()
            Text(error.localizedDescription)
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
                    //self.contentView.fetch.endpointType = .normal
                    self.contentView.fetch.forceFetch()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
    }
    
}
