//
//  TrendingMovieRepositoryImpl.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import SwiftUI

/// Main Tab Bar View for the TMBD Movie Demo app
struct MainTabBarView: View {
    @Environment(\.modelContext) private var modelContext
    
    init() {
        configureTabBarAppearance()
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(viewModel: makeHomeViewModel())
            }
            .tabItem {
                Label(Tab.home.title, systemImage: Tab.home.icon)
            }

            NavigationStack {
                BookMarkView(viewModel: makeBookmarkViewModel())
            }
            .tabItem {
                Label(Tab.bookmark.title, systemImage: Tab.bookmark.icon)
            }
        }
    }

    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
    }
    
    private func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            fetchTrendingMoviesUseCase: FetchTrendingMoviesUseCaseImpl(
                repository: HomeRespositoryImpl(context: modelContext)
            )
        )
    }
    
    private func makeBookmarkViewModel() -> HomeViewModel {
        HomeViewModel(
            fetchTrendingMoviesUseCase: FetchTrendingMoviesUseCaseImpl(
                repository: HomeRespositoryImpl(context: modelContext)
            )
        )
    }
}

/// Enum defining the tabs in the app
private enum Tab: String, CaseIterable {
    case home
    case bookmark
    
    var title: String {
        rawValue.capitalized
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .bookmark:
            return "bookmark.circle.fill"
        }
    }
}

#Preview {
    MainTabBarView()
}
