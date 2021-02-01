//
//  AppState.swift
//  ComposableArchitecture
//
//  Created by Adrian B. Haeske on 01.02.21.
//

import Foundation

class AppState: ObservableObject {
    @Published var count: Int = 0
    @Published var favoritePrimes: [Int] = []
    @Published var loggedInUser: User?
    @Published var activityFeed: [Activity] = []
    
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
