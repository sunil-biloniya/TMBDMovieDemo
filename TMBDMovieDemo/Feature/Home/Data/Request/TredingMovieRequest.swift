//
//  TredingMovieRequest.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

struct TrendingMovieRequest: RequestBuilder {
    var httpMethod: HTTPMethod = .get
    var endPoint: Endpoint
    var body: (any RequestBody)? = nil
    var pathComponent: [String] = []
    var queryParameters: [URLQueryItem] = []
    init(httpMethod: HTTPMethod, endPoint: Endpoint, body: (any RequestBody)? = nil, pathComponent: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.httpMethod = httpMethod
        self.endPoint = endPoint
        self.body = body
        self.pathComponent = pathComponent
        self.queryParameters = queryParameters
    }
}
