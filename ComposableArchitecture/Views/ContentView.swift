//
//  ContentView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: Store<AppState, CounterAction>
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: CounterView(store: self.store)) {
                    Text("Zähler")
                }
                NavigationLink(
                    destination: FavoritePrimesView(store: self.store)) {
                    Text("Lieblingsprimzahlen")
                }
            }
            .navigationTitle(Text("State Management"))
        }
    }
}
