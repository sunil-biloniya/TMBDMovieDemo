//
//  TrendingMovieRepositoryImpl.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Combine
import Foundation
import SwiftData

protocol HomeRespository {
    func fethCharacter(page: Int) -> AnyPublisher<CharacterModel, Error>
    func saveCharacter(character: CharacterModel)
}

class HomeRespositoryImpl: HomeRespository {
  
    private var networkService: NetworkServiceProtocol
    private let context: ModelContext

    init(networkService: NetworkServiceProtocol = NetworkService(), context: ModelContext) {
        self.networkService = networkService
        self.context = context
    }
    
    
    func fethCharacter(page: Int) -> AnyPublisher<CharacterModel, any Error> {
        let request = TrendingMovieRequest(httpMethod: .get, endPoint: .character, queryParameters: [URLQueryItem(name: "page", value: "\(page)")])
        return networkService
            .performRequest(request, responseType: CharacterModel.self)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    

    func saveCharacter(character: CharacterModel) {
        guard let results = character.results else { return }
        
        for result in results {
            let descriptor = FetchDescriptor<CResult>(predicate: #Predicate { $0.id == result.id })
            
            do {
                let exists = try context.fetch(descriptor)
                if exists.isEmpty {
                    context.insert(result)
                }
            } catch {
                print(error)
            }
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint("Save failed: \(error)")
            }
        }
    }
}
