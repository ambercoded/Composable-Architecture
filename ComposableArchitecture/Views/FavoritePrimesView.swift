//
//  FavoritePrimesView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct FavoritePrimesView: View {
    @ObservedObject var store: Store<AppState>
    
    var body: some View {
        List {
            ForEach(store.value.favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                for index in indexSet {
                    store.value.favoritePrimes.remove(at: index)
                }
            }
        }
        .navigationTitle("Lieblingsprimzahlen")
    }
}

struct FavoritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrimesView(store: Store(initialValue: AppState()))
    }
}
