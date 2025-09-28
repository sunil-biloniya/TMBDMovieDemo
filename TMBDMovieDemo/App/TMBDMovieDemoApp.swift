//
//  TMBDMovieDemoApp.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI
import SwiftData

@main
struct TMBDMovieDemoApp: App {
    @ObservedObject private var navigationCoordinator = NavigationCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationCoordinator.path) {
                MainTabBarView()
                    .navigationDestination(for: NavigationCoordinator.AuthFlow.self) { destinationPath in
                        navigationCoordinator.destination(for: destinationPath)
                    }
            }
            .environmentObject(navigationCoordinator)
        }
        .modelContainer(for: CharacterModel.self)
    }
}


