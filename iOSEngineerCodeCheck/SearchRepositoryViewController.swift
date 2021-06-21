//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var schBr: UISearchBar!

    var repository: [Repository] = []

    var task: URLSessionTask?
    var word: String = ""
    var urlString: String = ""
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        schBr.text = "GitHubのリポジトリを検索できるよー"
        schBr.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
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
                self?.repository = fetchedRepos.items
                DispatchQueue.main.async {[weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail", let index = selectedIndex {
            let dtl = segue.destination as? DetailRepositoryViewController
            dtl?.selectedRepository = repository[index]
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repository.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repository[indexPath.row]
        cell.textLabel?.text = rp.fullName
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
