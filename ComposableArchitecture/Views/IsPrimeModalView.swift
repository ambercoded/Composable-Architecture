//
//  IsPrimeModalView.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import SwiftUI

struct IsPrimeModalView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            if isPrime(self.state.count) {
                Text("\(self.state.count) is prime :)")
                
                if self.state.favoritePrimes.contains(self.state.count) {
                    Button(action: {
                        self.state.favoritePrimes.removeAll(where: { $0 == self.state.count })
                        self.state.activityFeed.append(.init(timestamp: Date(), activityType: .addedFavoritePrime(self.state.count)))
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        self.state.favoritePrimes.append(self.state.count)
                        self.state.activityFeed.append(AppState.Activity.init(timestamp: Date(), activityType: .removedFavoritePrime(self.state.count)))
                    }) {
                        Text("Add to favorite primes")
                    }
                }
                
            } else {
                Text("Unfortunately, \(self.state.count) is not prime :(")
            }
            
        }
        
        
    }
}

struct IsPrimeModalView_Previews: PreviewProvider {
    static var previews: some View {
        IsPrimeModalView(state: AppState())
    }
}
