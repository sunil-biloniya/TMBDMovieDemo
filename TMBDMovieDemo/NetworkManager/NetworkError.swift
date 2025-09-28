//
//  NetworkError.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

/// Define error
enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingError(Error)
    case invalidResponse
    case statusCode(Int)
    case noInternet

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The URL provided is invalid.", comment: "Invalid URL error")
        case .requestFailed(let error):
            return NSLocalizedString("Network request failed: \(error.localizedDescription)", comment: "Request failed error")
        case .noData:
            return NSLocalizedString("No data was received from the server.", comment: "No data error")
        case .decodingError(let error):
            return NSLocalizedString("Failed to decode the response: \(error.localizedDescription)", comment: "Decoding error")
        case .invalidResponse:
            return NSLocalizedString("The server response was invalid.", comment: "Invalid response error")
        case .statusCode(let code):
            return NSLocalizedString("Request failed with status code: \(code)", comment: "Status code error")
        case .noInternet:
            return NSLocalizedString("No internet connection available.", comment: "No internet error")
        }
    }

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.requestFailed(let lhsError), .requestFailed(let rhsError)):
            return (lhsError as NSError).code == (rhsError as NSError).code
        case (.noData, .noData):
            return true
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return (lhsError as NSError).code == (rhsError as NSError).code
        case (.invalidResponse, .invalidResponse):
            return true
        case (.statusCode(let lhsCode), .statusCode(let rhsCode)):
            return lhsCode == rhsCode
        case (.noInternet, .noInternet):
            return true
        default:
            return false
        }
    }
}
