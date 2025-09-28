//
//  BookMarkView.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI
import SwiftData


struct BookMarkView: View {
    @StateObject var viewModel: HomeViewModel
    @Query var characters: [CResult]
    @State private var bookmarkedCharacters: [CResult] = []

    var body: some View {
        NavigationStack {
            VStack {
                if bookmarkedCharacters.isEmpty {
                    EmptyStateView(
                        message: Constants.Labels.bookMarkNoData,
                        systemImage: Constants.Images.bookMarkSlashIcon
                    )
                } else {
                    BookmarkedCharactersList(
                        bookmarkedCharacters: bookmarkedCharacters,
                        onBookmarkToggle: { character in
                            viewModel.bookMark(result: character, allResult: characters)
                            bookmarkedCharacters = characters.filter { $0.isBookmarked }
                        },
                        viewModel: viewModel
                    )
                }
            }
            .navigationTitle(Constants.Navigation.bookMark)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                bookmarkedCharacters = characters.filter { $0.isBookmarked }
            }
        }
    }
}

struct BookmarkedCharactersList: View {
    let bookmarkedCharacters: [CResult]
    let onBookmarkToggle: (CResult) -> Void
    let viewModel: HomeViewModel

    var body: some View {
        List {
            ForEach(bookmarkedCharacters, id: \.id) { character in
                CharacterCardView(character: character) {
                    onBookmarkToggle(character)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
   // BookMarkView()
}
