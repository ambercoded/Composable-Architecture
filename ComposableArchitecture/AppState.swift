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
    let reducer: (Value, Action) -> Value
    @Published var value: Value
    
    init(initialValue: Value, reducer: @escaping (Value, Action) -> Value) {
        self.value = initialValue
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        self.value = self.reducer(self.value, action)
    }
}

enum CounterAction {
    case decreaseTapped
    case increaseTapped
}

func counterReducer(state: AppState, action: CounterAction) -> AppState {
    var copy = state
    switch action {
    case .decreaseTapped:
        copy.count -= 1
    case .increaseTapped:
        copy.count += 1
    }
    return copy
}
