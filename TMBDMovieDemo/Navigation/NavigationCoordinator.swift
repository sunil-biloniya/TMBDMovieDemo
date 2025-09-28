import Foundation
import SwiftUI

@MainActor
final class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to router: AuthFlow) {
        path.append(router)
    }
    
    func navigateBack() { // Fixed typo
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
    @ViewBuilder // Removed @discardableResult as it's not needed here
    func destination(for flow: AuthFlow) -> some View {
        switch flow {
        case .movieDetail(let result, let viewmodel):
            DetailsPage(result: result, viewmodel: viewmodel)
        }
    }
}

extension HomeViewModel: Hashable {
    nonisolated static func == (lhs: HomeViewModel, rhs: HomeViewModel) -> Bool {
        lhs === rhs
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
