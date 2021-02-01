//
//  IsPrimeModalView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct IsPrimeModalView: View {
    @ObservedObject var store: Store<AppState, CounterAction>
    
    var body: some View {
        VStack {
            if isPrime(self.store.value.count) {
                Text("\(self.store.value.count) is prime :)")
                
                if self.store.value.favoritePrimes.contains(self.store.value.count) {
                    Button(action: {
                        self.store.value.favoritePrimes.removeAll(where: { $0 == self.store.value.count })
                        self.store.value.activityFeed.append(.init(timestamp: Date(), activityType: .addedFavoritePrime(self.store.value.count)))
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        self.store.value.favoritePrimes.append(self.store.value.count)
                        self.store.value.activityFeed.append(AppState.Activity.init(timestamp: Date(), activityType: .removedFavoritePrime(self.store.value.count)))
                    }) {
                        Text("Add to favorite primes")
                    }
                }
                
            } else {
                Text("Unfortunately, \(self.store.value.count) is not prime :(")
            }
            
        }
        
        
    }
}
