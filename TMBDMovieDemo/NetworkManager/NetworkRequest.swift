//
//  NetworkRequest.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

final class NetworkRequest {
    
    private let builder: RequestBuilder
    
    init(builder: RequestBuilder) {
        self.builder = builder
    }
    
    public var urlRequest: URLRequest? {
        guard let url = buildURL() else {
            return nil
        }
        debugPrint(url)
        var request = URLRequest(url: url)
        request.httpMethod = builder.httpMethod.rawValue
        request.httpBody = builder.body?.encode()
        return request
    }
    
    private func buildURL() -> URL? {
        var constructedURL = ""
        switch ConfigurationManager.environment {
        case .development(let baseURL):
            constructedURL = baseURL
        case .production(let baseURL):
            constructedURL = baseURL
        }
        constructedURL += "/"
        constructedURL += builder.endPoint.rawValue
        if !builder.pathComponent.isEmpty {
            constructedURL += builder.pathComponent.compactMap({$0}).joined(separator: "/")
        }
        
        if !builder.queryParameters.isEmpty {
            constructedURL += "?"
            let augmentedParameters: String = builder.queryParameters.compactMap { param -> String? in
                guard let value = param.value else {
                    return nil
                }
                return "\(param.name)=\(value)"
            }.joined(separator: "&")
            constructedURL += augmentedParameters
        }
        return URL(string: constructedURL)
    }
    
}
