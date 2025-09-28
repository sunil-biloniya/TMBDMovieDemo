//
//  HomeView.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var characters: [CResult]
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.white).ignoresSafeArea()
                VStack {
                    SearchBar(text: $viewModel.searchText)
                    
                    if !filteredCharacters.isEmpty {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredCharacters, id: \.id) { character in
                                    NavigationLink(destination: DetailsPage(result: character, viewmodel: viewModel)) {
                                        CharacterCardView(character: character)
                                            .contentShape(Rectangle())
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .onAppear {
                                        if character == characters.last {
                                            viewModel.fetchIfNeeded(currentItem: character, fetchMore: true)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                    } else {
                        EmptyStateView(
                            message: Constants.Labels.charactersNoData,
                            systemImage: Constants.Images.bookMarkSlashIcon
                        )
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.Navigation.character)
        
        .alert(Constants.Labels.error, isPresented: $viewModel.showErrorAlert) {
            Button(Constants.Labels.ok) {
                viewModel.dismissError()
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? Constants.Labels.errorMsg)
        }
        .onAppear {
            viewModel.fetchIfNeeded(currentItem: characters.first)
        }
        
        .onDisappear {
            // Dismiss keyboard when the view disappears
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    var filteredCharacters: [CResult] {
        if viewModel.searchText.isEmpty {
            return characters
        } else {
            return characters.filter {
                $0.name?.localizedCaseInsensitiveContains(viewModel.searchText) ?? false ||
                $0.gender?.rawValue.localizedCaseInsensitiveContains(viewModel.searchText) ?? false ||
                $0.species?.rawValue.localizedCaseInsensitiveContains(viewModel.searchText) ?? false ||
                $0.status?.rawValue.localizedCaseInsensitiveContains(viewModel.searchText) ?? false
            }
        }
    }
}
