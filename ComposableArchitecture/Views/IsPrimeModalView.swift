//
//  IsPrimeModalView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct IsPrimeModalView: View {
    @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        VStack {
            if isPrime(self.store.value.count) {
                Text("\(self.store.value.count) is prime :)")
                
                if self.store.value.favoritePrimes.contains(self.store.value.count) {
                    Button(action: {
                            store.send(.primeModal(.addToFavoritePrimesTapped)) }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: { store.send(.primeModal(.removeFromFavoritePrimesTapped))}) {
                        Text("Add to favorite primes")
                    }
                }
                
            } else {
                Text("Unfortunately, \(self.store.value.count) is not prime :(")
            }
            
        }
        
        
    }
}
