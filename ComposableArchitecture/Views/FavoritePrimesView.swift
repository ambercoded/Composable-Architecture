//
//  FavoritePrimesView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct FavoritePrimesView: View {
    @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        List {
            ForEach(store.value.favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                store.send(.favoritePrimes(.deleteFavoritePrimes(indexSet)))
            }
        }
        .navigationTitle("Lieblingsprimzahlen")
    }
}
