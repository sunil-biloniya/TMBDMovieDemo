//
//  RequestBuilder.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

protocol RequestBuilder {
    var httpMethod: HTTPMethod { get }
    var endPoint: Endpoint { get }
    var body: RequestBody? { get }
    var pathComponent: [String] { get }
    var queryParameters: [URLQueryItem] { get }
}
