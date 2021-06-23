//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var languageLabel: UILabel!

    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!

    /// 選択されているリポジトリ
    var selectedRepository: Repository?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let repository = selectedRepository else { return }

        languageLabel.text = "Written in \(repository.language ?? "")"
        starsCountLabel.text = "\(repository.stargazersCount) stars"
        watchersCountLabel.text = "\(repository.watchersCount) watchers"
        forksCountLabel.text = "\(repository.forksCount) forks"
        issuesCountLabel.text = "\(repository.openIssuesCount) open issues"
        titleLabel.text = repository.fullName

        getImage(repository: repository)
    }

    func getImage(repository: Repository) {
        let owner = repository.owner
        let imageURL = owner.avatarUrl
        if let url = URL(string: imageURL) {
            self.imageView.setImage(url: url)
        }
    }
}
