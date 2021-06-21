//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var languageLabel: UILabel!

    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!

    var indexViewController: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let idx = indexViewController?.selectedIndex, let repo = indexViewController?.repository[idx] else { return }

        languageLabel.text = "Written in \(repo.language)"
        starsCountLabel.text = "\(repo.stargazersCount) stars"
        watchersCountLabel.text = "\(repo.watchersCount) watchers"
        forksCountLabel.text = "\(repo.forksCount) forks"
        issuesCountLabel.text = "\(repo.openIssuesCount) open issues"
        getImage(repository: repo)
    }

    func getImage(repository: Repository) {
        titleLabel.text = repository.fullName

        let owner = repository.owner
        let imgURL = owner.avatarUrl
        if let url = URL(string: imgURL) {
            URLSession.shared.dataTask(with: url) { data, _, err in
                if let error = err {
                    print(error)
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.imageView.image = image
                    }
                }
            }.resume()
        }
    }
}
