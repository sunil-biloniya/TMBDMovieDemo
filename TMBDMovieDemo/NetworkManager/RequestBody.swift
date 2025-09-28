//
//  RequestBody.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation

protocol RequestBody {
    func encode() -> Data?
}
struct JsonBody: RequestBody {
    let encodable: Encodable
    func encode() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(encodable)
    }
}
