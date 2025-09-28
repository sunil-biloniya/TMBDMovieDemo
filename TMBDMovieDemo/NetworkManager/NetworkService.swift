//
//  NetworkService.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Combine
import Foundation
protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(_ builder: RequestBuilder, responseType: T.Type) -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func performRequest<T: Decodable>(_ builder: RequestBuilder, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        if !NetworkReachability.isConnectedToNetwork() {
            return Fail(error: NetworkError.noInternet).eraseToAnyPublisher()
        }
        
        let networkRequest = NetworkRequest(builder: builder)
        
        guard let urlRequest = networkRequest.urlRequest else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.statusCode(httpResponse.statusCode)
                }
                // 📦 Log JSON
                if let json = try? JSONSerialization.jsonObject(with: data),
                   let pretty = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let string = String(data: pretty, encoding: .utf8) {
                    print("📦 JSON:\n\(string)")
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return NetworkError.requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
