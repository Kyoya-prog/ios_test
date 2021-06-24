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

class SearchRepositoryModelInputStub: SearchRepositoryModelInput {
    private var fetchRepositoriesResponce: [Repository] = []

    private var occuredError: Error?

    func addResponce(result: Result<[Repository], Error>) {
        switch result {
        case let .success(repositories):
            fetchRepositoriesResponce = repositories

        case let .failure(error):
            occuredError = error
        }
    }

    func searchRepositories(keyword: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        if let error = occuredError {
            completion(.failure(error))
            return
        }
        completion(.success(fetchRepositoriesResponce))
    }
}

class SearchRepositoryresenterTests: XCTestCase {
    override class func setUp() {
    }

    override class func tearDown() {
    }

    func testSearchActionWhenSuccess() {
        XCTContext.runActivity(named: "正常な検索時") { _ in
            let spy = SearchRepositoryPresenterOutputSpy()
            let stub = SearchRepositoryModelInputStub()
            let presenter = SearchRepositoryPresenter()
            presenter.output = spy
            presenter.model = stub
            let repositories: [Repository] = [.init(id: 1, name: "superLibrary", fullName: "tanaka/superLibrary", language: "Swift", stargazersCount: 100, watchersCount: 50, forksCount: 50, openIssuesCount: 30, owner: .init(login: "tanaka", avatarUrl: "https://example.com"))]
            stub.addResponce(result: .success(repositories))

            presenter.didTapSearchButton(text: "search")

            XCTAssertEqual(spy.countOfUpdateRepositoriesAction, 1)
            XCTAssertEqual(spy.countOfShowErrorAction, 0)
        }
    }

    func testSearchActionWhenError() {
        XCTContext.runActivity(named: "検索失敗時") { _ in
            let spy = SearchRepositoryPresenterOutputSpy()
            let stub = SearchRepositoryModelInputStub()
            let presenter = SearchRepositoryPresenter()
            presenter.output = spy
            presenter.model = stub
            let error = NSError()
            stub.addResponce(result: .failure(error))

            presenter.didTapSearchButton(text: "search")

            XCTAssertEqual(spy.countOfUpdateRepositoriesAction, 0)
            XCTAssertEqual(spy.countOfShowErrorAction, 1)
        }
    }

    func testDidSelectRepository() {
        XCTContext.runActivity(named: "リポジトリセルタップ時") { _ in
            let spy = SearchRepositoryPresenterOutputSpy()
            let stub = SearchRepositoryModelInputStub()
            let presenter = SearchRepositoryPresenter()
            presenter.output = spy
            presenter.model = stub
            let repositories: [Repository] = [.init(id: 1, name: "superLibrary", fullName: "tanaka/superLibrary", language: "Swift", stargazersCount: 100, watchersCount: 50, forksCount: 50, openIssuesCount: 30, owner: .init(login: "tanaka", avatarUrl: "https://example.com"))]
            stub.addResponce(result: .success(repositories))

            presenter.didTapSearchButton(text: "search")
            presenter.didSelectRepository(repository: repositories[0])

            XCTAssertEqual(spy.countOfUpdateRepositoriesAction, 1)
            XCTAssertEqual(spy.countOfShowErrorAction, 0)
            XCTAssertEqual(spy.countOfTransitionToRepositoryDetailAction, 1)
        }
    }
}
