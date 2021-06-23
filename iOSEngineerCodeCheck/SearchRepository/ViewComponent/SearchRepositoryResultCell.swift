import Foundation
import UIKit

class SearchRepositoryResultCell: UITableViewCell {
    static let reuseIdentifer = "search-repository-result-cell"

    var profileImageURL: URL? {
        didSet {
            if let url = profileImageURL {
                profileImageView.setImage(url: url)
            }
        }
    }

    var userName: String = ""{
        didSet {
            userNameLabel.text = "UserName:\(userName)"
        }
    }

    var repositoryName: String = ""{
        didSet {
            repositoryNameLabel.text = repositoryName
        }
    }

    var language: String? {
        didSet {
            languageLabel.text = "Written in \(language ?? "Unknown Language")"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    override func prepareForReuse() {
        profileImageView.af.cancelImageRequest()
        profileImageView.image = nil

        userNameLabel.text = ""
        repositoryNameLabel.text = ""
        languageLabel.text = ""
    }

    private func setUp() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(hex: "ff6600", alpha: 0.5)
        contentView.addSubview(containerView)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1
        containerView.addSubview(profileImageView)

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        userNameLabel.textColor = .black
        containerView.addSubview(userNameLabel)

        repositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repositoryNameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        repositoryNameLabel.numberOfLines = 2
        repositoryNameLabel.textColor = .black
        containerView.addSubview(repositoryNameLabel)

        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.font = UIFont.systemFont(ofSize: 15)
        languageLabel.textColor = .black
        containerView.addSubview(languageLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),

            userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10),
            userNameLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -5),

            repositoryNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            repositoryNameLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor),
            repositoryNameLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -5),

            languageLabel.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 10),
            languageLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor),
            languageLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -5),
            languageLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    private let profileImageView = UIImageView()

    private let userNameLabel = UILabel()

    private let repositoryNameLabel = UILabel()

    private let languageLabel = UILabel()

    private let containerView = UIView()
}
