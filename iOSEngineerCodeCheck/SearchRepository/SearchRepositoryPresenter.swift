import Foundation

class SearchRepositoryPresenter: SearchRepositoryPresenterInput {
    var output: SearchRepositoryPresenterOutput?

    var model: SearchRepositoryModel!

    func didTapSearchButton(text: String?) {
        guard let keyword = text else { return }

        model.searchRepositories(keyword: keyword) {[weak self] result in
            switch result {
            case let .success(repositories):
                self?.output?.updateRepositories(repositories: repositories)

            case let .failure(error):
                print(error)
            }
        }
    }

    func didSelectRepository(repository: Repository) {
        output?.transitionToRepositoryDetail(repository: repository)
    }
}
