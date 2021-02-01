//
//  AppState.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import Foundation

struct AppState {
    var count: Int = 0
    var favoritePrimes: [Int] = []
    var loggedInUser: User?
    var activityFeed: [Activity] = []
    
    struct Activity {
        let timestamp: Date
        let activityType: ActivityType
        
        enum ActivityType {
            case addedFavoritePrime(Int)
            case removedFavoritePrime(Int)
        }
    }
    
    struct User {
        let id: Int
        let name: String
        let bio: String
    }
}

final class Store<Value, Action>: ObservableObject { // Store<AppState>
    let reducer: (inout Value, Action) -> Void
    @Published var value: Value
    
    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.reducer = reducer
        self.value = initialValue
    }
    
    func send(_ action: Action) {
        self.reducer(&self.value, action)
    }
}

// MARK: - Reducer Actions
enum AppAction {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
    case favoritePrimes(FavoritePrimesAction)
    
    enum CounterAction {
        case decreaseTapped
        case increaseTapped
    }
    
    enum PrimeModalAction {
        case addToFavoritePrimesTapped
        case removeFromFavoritePrimesTapped
    }
    
    enum FavoritePrimesAction {
        case deleteFavoritePrimes(IndexSet)
    }
}



func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .counter(.decreaseTapped):
        state.count -= 1
        
    case .counter(.increaseTapped):
        state.count += 1
        
    case .primeModal(.addToFavoritePrimesTapped):
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        state.activityFeed.append(.init(timestamp: Date(), activityType: .addedFavoritePrime(state.count)))
        
    case .primeModal(.removeFromFavoritePrimesTapped):
        state.favoritePrimes.append(state.count)
        state.activityFeed.append(.init(timestamp: Date(), activityType: .removedFavoritePrime(state.count)))
        
    case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
        for index in indexSet {
            let prime = state.favoritePrimes[index]
            state.favoritePrimes.remove(at: index)
            state.activityFeed.append(.init(timestamp: Date(), activityType: .removedFavoritePrime(prime)))
        }
    }
    
}
