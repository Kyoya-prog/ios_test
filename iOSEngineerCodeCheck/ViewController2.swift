//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var TtlLbl: UILabel!
    
    @IBOutlet weak var LangLbl: UILabel!
    
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var vc1: ViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let idx = vc1?.idx,let repo = vc1?.repo[idx] else { return }
        
        LangLbl.text = "Written in \(repo.language)"
        StrsLbl.text = "\(repo.stargazersCount) stars"
        WchsLbl.text = "\(repo.watchersCount) watchers"
        FrksLbl.text = "\(repo.forksCount) forks"
        IsssLbl.text = "\(repo.openIssuesCount) open issues"
        getImage(repository: repo)
        
    }
    
    func getImage(repository:Repository){
        
        TtlLbl.text = repository.fullName
        
        let owner = repository.owner
        let imgURL = owner.avatarUrl
        if let url = URL(string: imgURL){
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                if let data = data,let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.ImgView.image = image
                    }
                }
            }.resume()
        }
    }
    
}
