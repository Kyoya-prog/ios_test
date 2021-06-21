import Foundation

// TODO: Detailの名前変更

/// リポジトリ検索View
protocol SearchRepositoryPresenterOutput: AnyObject {
    /// リポジトリ一覧を更新する
    /// - parameter repositories:リポジトリ一覧
    func updateRepositories(repositories: [Repository])

    /// リポジトリ詳細画面に遷移する
    /// - parameter repository:詳細表示するリポジトリ
    func transitionToRepositoryDetail(repository: Repository)
}

/// リポジトリ検索Presentation
protocol SearchRepositoryPresenterInput: AnyObject {
    /// 検索ボタンが押された
    /// - parameter text:検索テキスト
    func didTapSearchButton(text: String?)

    /// リポジトリが選択された
    /// - parameter repository:選択されたリポジトリ
    func didSelectRepository(repository: Repository)
}

/// リポジトリ検索Usecase
protocol SearchRepositoryModelInput: AnyObject {
    /// リポジトリを検索する
    /// - parameter keyword:検索キーワード
    func searchRepositories(keyword: String)
}
