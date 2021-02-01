//
//  ContentView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: Store<AppState>
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store.init(initialValue: AppState()))
    }
}
