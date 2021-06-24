import XCTest
@testable import iOSEngineerCodeCheck

class SearchRepositoryPresenterOutputSpy:SearchRepositoryPresenterOutput{
    
    private(set) var countOfInvokingUpdateRepositories = 0
    private(set) var countOfInvokingTransitionToRepositoryDetail = 0
    private(set) var countOfInvokingShowError = 0
    
    var updateRepositoriesAction: (([Repository]) -> Void)?
    var transitionToRepositoryDetailAction: ((Repository) -> Void)?
    var showErrorAction:((String) -> Void)?
    
    var presenterInput: SearchRepositoryPresenterInput!
    
    func updateRepositories(repositories: [Repository]) {
        countOfInvokingUpdateRepositories += 1
        updateRepositoriesAction?(repositories)
    }
    
    func transitionToRepositoryDetail(repository: Repository) {
        countOfInvokingTransitionToRepositoryDetail += 1
        transitionToRepositoryDetailAction?(repository)
    }
    
    func showError(message: String) {
        countOfInvokingShowError += 1
        showErrorAction?(message)
    }
    
    
}
