//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UIViewController, SearchRepositoryPresenterOutput {
    /// 表示するリポジトリ一覧
    var repositories: [Repository] = []

    ///　URLセッションタスク
    var task: URLSessionTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "リポジトリ検索画面"

        setUp()
    }

    // MARK: SeachRepositoryPresenterOutput
    var presenterInput: SearchRepositoryPresenterInput!

    func updateRepositories(repositories: [Repository]) {
        self.repositories = repositories
        repositoriesView.reloadData()
    }

    func transitionToRepositoryDetail(repository: Repository) {
        presentDetailRepositoryView(repository: repository)
    }

    // MARK: Private
    private func presentDetailRepositoryView(repository: Repository) {
        let detailViewController = ModuleAssembler.assembleDetailRepositoryModule(repository: repository)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    private func setUp() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "リポジトリを検索"
        view.addSubview(searchBar)

        repositoriesView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(repositoriesView)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            repositoriesView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            repositoriesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            repositoriesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            repositoriesView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private let searchBar = UISearchBar()

    private lazy var repositoriesView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(SearchRepositoryResultCell.self, forCellReuseIdentifier: SearchRepositoryResultCell.reuseIdentifer)
        return view
    }()
}

// MARK: UISearchBarDelegate
extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 初期のテキストをリセットする
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenterInput.didTapSearchButton(text: searchBar.text)
    }
}

// MARK: UITableViewController
extension SearchRepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchRepositoryResultCell.reuseIdentifer) as! SearchRepositoryResultCell
        let repository = repositories[indexPath.row]
        cell.userName = repository.name
        cell.repositoryName = repository.owner.login
        cell.language = repository.language
        cell.profileImageURL = URL(string: repository.owner.avatarUrl)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterInput.didSelectRepository(repository: repositories[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
