//
//  ContentView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var state: AppState
    
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: CounterView(state: state)) {
                    Text("Zähler")
                }
                NavigationLink(
                    destination: FavoritePrimesView(state: state)) {
                    Text("Lieblingsprimzahlen")
                }
            }
            .navigationTitle(Text("State Management"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
