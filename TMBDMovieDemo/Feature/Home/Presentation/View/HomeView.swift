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
    
    @EnvironmentObject var router: NavigationCoordinator
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack {
                SearchBar(text: $viewModel.searchText)
                
                if !filteredCharacters.isEmpty {
                    List {
                        ForEach(filteredCharacters, id: \.id) { character in
                            CharacterCardView(character: character)
                                .onTapGesture {
                                    router.navigate(to: .movieDetail(character, viewModel))
                                }
                                .onAppear {
                                    if character == characters.last {
                                        viewModel.fetchIfNeeded(currentItem: character, fetchMore: true)
                                    }
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    EmptyStateView(
                        message: Constants.Labels.charactersNoData,
                        systemImage: Constants.Images.bookMarkSlashIcon
                    )
                }
            }
        }
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
