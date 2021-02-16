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
///     -  contentView: The `ContentView` that contains the`EmptyView`.
///
struct EmptyView: View {
    
    var contentView: ContentView
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: -25) {
            Text("No Cars Found!")
                .fontWeight(.bold)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
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
                    self.contentView.fetch.endpointType = .normal
                    //self.contentView.fetch.forceFetch()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(contentView: ContentView())
    }
}
