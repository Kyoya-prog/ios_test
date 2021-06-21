//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!

    var repositories: [Repository] = []

    ///　URLセッションタスク
    var task: URLSessionTask?

    /// 選択されたインデックス番号
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 初期のテキストをリセットする
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)") else { return }

        task = URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
            if let error = err {
                print(error)
            }
            if let data = data, let fetchedRepos = try? JSONDecoder().decode(SearchRepositories.self, from: data) {
                self?.repositories = fetchedRepos.items
                DispatchQueue.main.async {[weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
        // taskを開始する
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 画面遷移直前に呼ばれる
        if segue.identifier == "Detail", let index = selectedIndex {
            let detailView = segue.destination as? DetailRepositoryViewController
            detailView?.selectedRepository = repositories[index]
        }
    }

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
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}