//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var ttlLbl: UILabel!

    @IBOutlet weak var langLbl: UILabel!

    @IBOutlet weak var strsLbl: UILabel!
    @IBOutlet weak var wchsLbl: UILabel!
    @IBOutlet weak var frksLbl: UILabel!
    @IBOutlet weak var isssLbl: UILabel!

    var vc1: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let idx = vc1?.idx, let repo = vc1?.repo[idx] else { return }

        langLbl.text = "Written in \(repo.language)"
        strsLbl.text = "\(repo.stargazersCount) stars"
        wchsLbl.text = "\(repo.watchersCount) watchers"
        frksLbl.text = "\(repo.forksCount) forks"
        isssLbl.text = "\(repo.openIssuesCount) open issues"
        getImage(repository: repo)
    }

    func getImage(repository: Repository) {
        ttlLbl.text = repository.fullName

        let owner = repository.owner
        let imgURL = owner.avatarUrl
        if let url = URL(string: imgURL) {
            URLSession.shared.dataTask(with: url) { data, _, err in
                if let error = err {
                    print(error)
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.imgView.image = image
                    }
                }
            }.resume()
        }
    }
}
