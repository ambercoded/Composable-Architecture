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
enum CounterAction {
    case decreaseTapped
    case increaseTapped
}

enum PrimeModalAction {
    case addToFavoritePrimesTapped(Int)
    case removeFromFavoritePrimesTapped(Int)
}

func counterReducer(state: inout AppState, action: CounterAction) {
    switch action {
    case .decreaseTapped:
        state.count -= 1
    case .increaseTapped:
        state.count += 1
    }
}
