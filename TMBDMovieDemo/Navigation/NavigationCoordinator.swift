//
//  NavigationCoordinator.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation
import SwiftUI

@MainActor
final class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to router: AuthFlow) {
        path.append(router)
    }
    
    func nvaigateBack() {
        path.removeLast()
    }
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    
    enum AuthFlow: Hashable {
        case movieDetail(CResult, HomeViewModel)
    }
}

extension NavigationCoordinator {
    @discardableResult
    @ViewBuilder
    func destination(for flow: AuthFlow) -> some View {
        
        switch flow {
        case .movieDetail(let result, let viewmodel):
            DetailsPage(result: result, viewmodel: viewmodel)
        }
    }
}


extension HomeViewModel: Hashable {
    static func == (lhs: HomeViewModel, rhs: HomeViewModel) -> Bool {
        lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
