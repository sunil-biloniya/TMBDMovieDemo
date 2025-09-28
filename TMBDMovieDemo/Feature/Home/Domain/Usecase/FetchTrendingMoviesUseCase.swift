//
//  FetchTrendingMoviesUseCase.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation
import Combine

protocol FetchTrendingMoviesUseCase {
    func fetchCharacter(page: Int) -> AnyPublisher<CharacterModel, Error>
    func saveCharacter(_ character: CharacterModel) async
}

class FetchTrendingMoviesUseCaseImpl: FetchTrendingMoviesUseCase {
    
    private let repository: HomeRespository
    
    init(repository: HomeRespository) {
        self.repository = repository
    }
    
    func fetchCharacter(page: Int) -> AnyPublisher<CharacterModel, Error> {
        repository.fethCharacter(page: page)
    }
    
    func saveCharacter(_ character: CharacterModel) {
        repository.saveCharacter(character: character)
    }
}
