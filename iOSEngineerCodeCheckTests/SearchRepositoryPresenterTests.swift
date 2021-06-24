@testable import iOSEngineerCodeCheck
import XCTest

class SearchRepositoryPresenterOutputSpy: SearchRepositoryPresenterOutput {
    private(set) var countOfUpdateRepositoriesAction = 0
    // swiftlint:disable:next identifier_name
    private(set) var countOfTransitionToRepositoryDetailAction = 0
    private(set) var countOfShowErrorAction = 0

    var updateRepositoriesAction: (([Repository]) -> Void)?
    var transitionToRepositoryDetailAction: ((Repository) -> Void)?
    var showErrorAction: ((String) -> Void)?

    var presenterInput: SearchRepositoryPresenterInput!

    func updateRepositories(repositories: [Repository]) {
        countOfUpdateRepositoriesAction += 1
        updateRepositoriesAction?(repositories)
    }

    func transitionToRepositoryDetail(repository: Repository) {
        countOfTransitionToRepositoryDetailAction += 1
        transitionToRepositoryDetailAction?(repository)
    }

    func showError(message: String) {
        countOfShowErrorAction += 1
        showErrorAction?(message)
    }
}


