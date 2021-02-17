//
//  CarListView.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/16/21.
//

import Foundation
import SwiftUI
import SwiftUIRefresh

/// Car List View.
///
/// - Properties
///     -  searchBar: The `SearchBar` to display in the `List`.
///     -  fetch: The `FetchCars` object that is observing for changes to the car list, loading status, and any errors.
///     -  flag: Boolean value to toggle the 'Loading Cars...' animation.
///     -  isShowing: Boolean value representing whether the `UIRefreshControl` is visible.
///     -  sort: Integer value representing the sorting option currently selected.
///     -  carList: Array of `Car` sorted according to `sort`.
///
struct CarListView: View {
    
    /// The `SearchBar` to display in the `List`.
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    /// The `FetchCars` object that is observing for changes to the car list, loading status, and any errors.
    @ObservedObject var fetch = FetchCars()
    
    /// Boolean value to toggle the 'Loading Cars...' animation.
    @State private var flag = false
    
    /// Boolean value representing whether the `UIRefreshControl` is visible.
    @State var isShowing = false
    
    /// Integer value representing the sorting option currently selected.
    @State var sort: Int = 0
    
    /// Array of `Car` sorted according to sorted according to the sorting option currently selected.
    var carList : [Car] {
        switch sort {
        case 1: return fetch.cars.sorted { $0.makeModel > $1.makeModel }
        case 2: return fetch.cars.sorted { $0.year < $1.year }
        case 3: return fetch.cars.sorted { $0.year > $1.year }
        case 4: return fetch.cars.sorted { $0.price < $1.price }
        case 5: return fetch.cars.sorted { $0.price > $1.price }
        default: return fetch.cars.sorted { $0.makeModel < $1.makeModel }
        }
    }
    
    var body: some View {
        // MARK: - Handling Loading State
        if fetch.loading {
            VStack {
                Spacer()
                Color.clear.overlay(WaveText("Loading Cars...", waveWidth: 6, pct: flag ? 1.0 : 0.0).foregroundColor(Color.init(white: 0.5, opacity: 0.8))).frame(height: 40)
                Spacer()
            }.onAppear {
                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                    self.flag.toggle()
                }
            }
        } else {
            NavigationView {
                if let error = fetch.error {
                    // MARK: - Handling Error State
                    ErrorAlertView(error: error, carListView: self)
                } else {
                    //Check if carList is empty
                    if carList.count > 0 {
                        // MARK: - Handling Success State
                        CarsView(carListView: self)
                    } else {
                        // MARK: - Handling Empty State
                        EmptyView(carListView: self)
                    }
                }
            }
            //Removes UISplitViewController style to retain the UI state on screen rotation.
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}

