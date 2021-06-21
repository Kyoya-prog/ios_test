import Foundation

class SearchRepositoryModel: SearchRepositoryModelInput {
    func searchRepositories(keyword: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        APIClient().send(SearchRepositoryTarget(keyword: keyword)) { responce in
            switch responce {
            case .success(let repositories):
                completion(.success(repositories.items))

            case .failure(let error):
                completion(.failure(error as NSError))
            }
        }
    }
}
