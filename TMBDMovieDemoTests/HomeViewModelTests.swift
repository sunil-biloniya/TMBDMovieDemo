//
//  HomeRepositoryImplTests.swift
//  TMBDMovieDemoTests
//
//  Created by IOS Developer on 28/09/25.
//
import XCTest
import Combine
@testable import TMBDMovieDemo

import XCTest
import Combine
import SwiftData
@testable import TMBDMovieDemo

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockUseCase: MockFetchTrendingMoviesUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchTrendingMoviesUseCase()
        viewModel = HomeViewModel(fetchTrendingMoviesUseCase: mockUseCase)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCharacterSuccess() {
        // Given
        let location = Location(name: "Earth", url: "https://example.com/earth")
        let result = CResult(
            id: 1,
            name: "Test Character",
            status: .alive,
            species: .human,
            type: "",
            gender: .male,
            origin: location,
            location: location,
            image: "https://example.com/image.jpg",
            episode: ["https://example.com/episode/1"],
            url: "https://example.com/character/1",
            created: "2023-01-01T00:00:00Z",
            isBookmarked: false
        )
        let expectedCharacter = CharacterModel(
            info: Info(count: 1, pages: 1, next: "page=2", prev: ""),
            results: [result]
        )
        mockUseCase.mockCharacter = expectedCharacter
        let expectation = XCTestExpectation(description: "Fetch character completes")

        // When
        viewModel.fetchCharacter(page: 1)

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.page, 2, "Page should increment when next page exists")
            XCTAssertFalse(self.viewModel.showErrorAlert, "Error alert should not be shown")
            XCTAssertNil(self.viewModel.error, "Error should be nil")
            XCTAssertEqual(self.mockUseCase.savedCharacter?.results?.first?.id, expectedCharacter.results?.first?.id, "Saved character should match")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchIfNeededWithCurrentItem() {
        // Given
        let location = Location(name: "Earth", url: "https://example.com/earth")
        let currentItem = CResult(
            id: 1,
            name: "Test Character",
            status: .alive,
            species: .human,
            type: "",
            gender: .male,
            origin: location,
            location: location,
            image: "https://example.com/image.jpg",
            episode: ["https://example.com/episode/1"],
            url: "https://example.com/character/1",
            created: "2023-01-01T00:00:00Z",
            isBookmarked: false
        )
        mockUseCase.mockCharacter = CharacterModel(
            info: Info(count: 1, pages: 1, next: "", prev: ""),
            results: [currentItem]
        )
        let initialPage = viewModel.page

        // When
        viewModel.fetchIfNeeded(currentItem: currentItem, fetchMore: true)

        // Then
        XCTAssertTrue(mockUseCase.fetchCharacterCalled, "fetchCharacter should be called")
        XCTAssertEqual(mockUseCase.lastFetchedPage, initialPage, "Should fetch with current page")
    }

    func testBookmarkTogglesCorrectly() {
        // Given
        let location = Location(name: "Earth", url: "https://example.com/earth")
        let result = CResult(
            id: 1,
            name: "Test Character",
            status: .alive,
            species: .human,
            type: "",
            gender: .male,
            origin: location,
            location: location,
            image: "https://example.com/image.jpg",
            episode: ["https://example.com/episode/1"],
            url: "https://example.com/character/1",
            created: "2023-01-01T00:00:00Z",
            isBookmarked: false
        )
        let allResults = [result]

        // When
        let isBookmarked = viewModel.bookMark(result: result, allResult: allResults)

        // Then
        XCTAssertTrue(isBookmarked, "Bookmark should be toggled to true")
        XCTAssertTrue(result.isBookmarked, "Result should be bookmarked")

        // When (toggle back)
        let isUnbookmarked = viewModel.bookMark(result: result, allResult: allResults)

        // Then
        XCTAssertFalse(isUnbookmarked, "Bookmark should be toggled to false")
        XCTAssertFalse(result.isBookmarked, "Result should not be bookmarked")
    }

    func testFetchCharacterFailure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 404, userInfo: nil)
        mockUseCase.mockError = expectedError
        let expectation = XCTestExpectation(description: "Fetch character fails")

        // When
        viewModel.fetchCharacter(page: 1)

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.viewModel.error, "Error should be set")
            XCTAssertTrue(self.viewModel.showErrorAlert, "Error alert should be shown")
            XCTAssertEqual(self.viewModel.error as NSError?, expectedError, "Error should match expected error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchIfNeededWithoutCurrentItem() {
        // Given
        viewModel.page = 5 // Set a different page to verify reset

        // When
        viewModel.fetchIfNeeded(currentItem: nil, fetchMore: false)

        // Then
        XCTAssertTrue(mockUseCase.fetchCharacterCalled, "fetchCharacter should be called")
        XCTAssertEqual(mockUseCase.lastFetchedPage, 1, "Should reset to page 1")
    }

    func testDismissError() {
        // Given
        viewModel.error = NSError(domain: "TestError", code: 404, userInfo: nil)
        viewModel.showErrorAlert = true

        // When
        viewModel.dismissError()

        // Then
        XCTAssertNil(viewModel.error, "Error should be nil after dismiss")
        XCTAssertFalse(viewModel.showErrorAlert, "Error alert should be hidden")
    }
}

// Mock Use Case for testing
class MockFetchTrendingMoviesUseCase: FetchTrendingMoviesUseCase {
    var mockCharacter: CharacterModel?
    var mockError: Error?
    var fetchCharacterCalled = false
    var lastFetchedPage: Int?
    var savedCharacter: CharacterModel?

    func fetchCharacter(page: Int) -> AnyPublisher<CharacterModel, Error> {
        fetchCharacterCalled = true
        lastFetchedPage = page
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        guard let character = mockCharacter else {
            return Fail(error: NSError(domain: "NoData", code: -1, userInfo: nil)).eraseToAnyPublisher()
        }
        return Just(character)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func saveCharacter(_ character: CharacterModel) async {
        savedCharacter = character
    }
}
