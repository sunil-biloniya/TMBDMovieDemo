//
//  ConfigurationManager.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

enum ConfigurationManager {
    enum  Environment {
        case production(String)
        case development(String)
    }
    static var environment: Environment {
        switch ProcessInfo.processInfo.environment["ENVIRONMENT"] ?? "development" {
        case "development":
            return .development("https://rickandmortyapi.com/api")
        default:
            return .production("https://api.themoviedb.org/3")
        }
    }
}
///https://rickandmortyapi.com/api

/// https://api.themoviedb.org/3
