import Foundation

class SearchRepositoryModel: SearchRepositoryModelInput {
    func searchRepositories(keyword: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        APIClient().send(SearchRepositoryTarget(keyword: keyword)) { responce in
            switch responce {
            case let .success(repositories):
                completion(.success(repositories.items))

            case let .failure(error):
                completion(.failure(error as NSError))
            }
        }
    }
}
