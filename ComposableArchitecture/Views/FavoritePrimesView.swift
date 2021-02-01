//
//  FavoritePrimesView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct FavoritePrimesView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        List {
            ForEach(state.favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                for index in indexSet {
                    state.favoritePrimes.remove(at: index)
                }
            }
        }
        .navigationTitle("Lieblingsprimzahlen")
    }
}

struct FavoritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrimesView(state: AppState())
    }
}
