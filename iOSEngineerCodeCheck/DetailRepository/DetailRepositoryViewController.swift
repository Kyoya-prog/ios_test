//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    /// 選択されているリポジトリ
    var selectedRepository: Repository?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Private

    private func setUp() {
        guard let repository = selectedRepository else { return }

        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.repository = repository
        view.addSubview(detailView)

        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private let detailView = DetailRepositoryView()
}
