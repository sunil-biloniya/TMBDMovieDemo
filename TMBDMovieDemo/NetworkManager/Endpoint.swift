//
//  Endpoint.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

enum Endpoint: String {
    case trending = "trending/"
    case location = "location/"
    case character
}

enum APIVersion {
    case v1
    case v2
}
