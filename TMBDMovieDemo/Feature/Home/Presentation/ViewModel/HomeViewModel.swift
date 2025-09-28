//
//  HomeViewModel.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    private let fetchTrendingMoviesUseCase: FetchTrendingMoviesUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var page = 1
    @Published var searchText: String = ""
    @Published var error: Error? // Already present
    @Published var showErrorAlert: Bool = false // New property to control alert visibility
    
    private var hasNextPage = true
    
    init(fetchTrendingMoviesUseCase: FetchTrendingMoviesUseCase) {
        self.fetchTrendingMoviesUseCase = fetchTrendingMoviesUseCase
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    func fetchIfNeeded(currentItem: CResult?, fetchMore: Bool = false) {
        guard (currentItem != nil) && fetchMore else {
            fetchCharacter(page: 1)
            return
        }
        fetchCharacter(page: page)
    }
    
    func fetchCharacter(page: Int) {
        fetchTrendingMoviesUseCase.fetchCharacter(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                    self?.showErrorAlert = true // Show alert on error
                }
            }, receiveValue: { [weak self] characterResponseModel in
                Task {
                    await self?.saveCharacter(character: characterResponseModel)
                }
            })
            .store(in: &cancellables)
    }
    
    func saveCharacter(character: CharacterModel) async {
        if let _ = character.info?.next {
            await MainActor.run {
                self.page += 1
            }
        } else {
            self.hasNextPage = false
        }
        await fetchTrendingMoviesUseCase.saveCharacter(character)
    }
    
    @discardableResult
    func bookMark(result: CResult, allResult: [CResult]) -> Bool {
        let bookMark = allResult.first(where: { $0.id == result.id })
        if bookMark?.isBookmarked ?? false {
            bookMark?.isBookmarked = false
            return false
        } else {
            bookMark?.isBookmarked = true
            return true
        }
    }
    
    // Function to reset error state when alert is dismissed
    func dismissError() {
        error = nil
        showErrorAlert = false
    }
}
