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
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
        .modelContainer(for: CharacterModel.self)
    }
}


