//
//  ContentView.swift
//  Dillon_Murphy
//
//  Created by Dillon Murphy on 2/10/21.
//

import Foundation
import SwiftUI
import SwiftUIRefresh

struct ContentView: View {
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @ObservedObject var fetch = FetchCars()
    
    @State private var flag = false
    
    @State private var isShowing = false
    
    @State private var sort: Int = 0
    
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
                    ErrorAlertView(error: error, contentView: self)
                } else {
                    if carList.count > 0 {
                        // MARK: - Handling Success State
                        List(carList.filter {
                            searchBar.text.isEmpty || $0.searchString.localizedStandardContains(searchBar.text)
                        }, id: \.self) { car in
                            // Adding Car Detail View as Destination View
                            //NavigationLink(destination: CarView(car: car)) {
                                CarCell(car: car)
                            //}
                        }
                        .pullToRefresh(isShowing: $isShowing) {
                             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isShowing = false
                                self.fetch.forceFetch()
                             }
                        }
                        .onChange(of: self.isShowing) { value in }
                        .padding([.leading,.trailing], -15.0)
                        .navigationTitle("Cars")
                        .add(self.searchBar)
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
                                    Picker("Sorting Options", selection: $sort) {
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
                    } else {
                        // MARK: - Handling Empty State
                        EmptyView(contentView: self)
                    }
                }
            }
            //Removes UISplitViewController style to retain the UI state.
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
