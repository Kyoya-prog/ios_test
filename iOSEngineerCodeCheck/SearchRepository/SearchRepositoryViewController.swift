//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController, SearchRepositoryPresenterOutput {
    @IBOutlet weak var searchBar: UISearchBar!

    /// 表示するリポジトリ一覧
    var repositories: [Repository] = []

    ///　URLセッションタスク
    var task: URLSessionTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    // MARK: SeachRepositoryPresenterOutput
    var presenterInput: SearchRepositoryPresenterInput!

    func updateRepositories(repositories: [Repository]) {
        self.repositories = repositories
        tableView.reloadData()
    }

    func transitionToRepositoryDetail(repository: Repository) {
        presentDetailRepositoryView(repository: repository)
    }

    private func presentDetailRepositoryView(repository: Repository) {
        let detailViewController = ModuleAssembler.assembleDetailRepositoryModule(repository: repository)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
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
extension SearchRepositoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterInput.didSelectRepository(repository: repositories[indexPath.row])
    }
}
