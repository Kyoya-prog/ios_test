import Foundation
import UIKit

class DetailRepositoryView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    var repository: Repository? {
        didSet {
            if let url = URL(string: repository?.owner.avatarUrl ?? "") {
                profileImageView.setImage(url: url)
            }
            titleLabel.text = repository?.fullName
            languageLabel.text = repository?.language
            starsCountLabel.text = "\(repository?.stargazersCount ?? 0) stars"
            watchersCountLabel.text = "\(repository?.watchersCount ?? 0) watchers"
            forksCountLabel.text = "\(repository?.forksCount ?? 0) forks"
            issuesCountLabel.text = "\(repository?.openIssuesCount ?? 0) issues"
        }
    }

    private func setUp() {
        backgroundColor = UIColor(hex: "ff6600", alpha: 0.3)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)

        vstack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vstack)

        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)

        whatLanguageLabel.text = "主に使用されている言語"

        languageLabel.font = UIFont.systemFont(ofSize: 15)

        howManyStarsCountLabel.text = "つけられたstar数"

        starsCountLabel.font = UIFont.systemFont(ofSize: 15)

        howManyWatchersCountLabel.text = "ウォッチャー数"

        howManyForksCountLabel.text = "forkされた回数"

        forksCountLabel.font = UIFont.systemFont(ofSize: 15)

        howManyIssuesCountLabel.text = "報告されているissue数"

        issuesCountLabel.font = UIFont.systemFont(ofSize: 15)

        vstack.addArrangedSubview(profileImageView)
        vstack.addArrangedSubview(titleLabel)
        vstack.addArrangedSubview(whatLanguageLabel)
        vstack.addArrangedSubview(languageLabel)
        vstack.addArrangedSubview(howManyStarsCountLabel)
        vstack.addArrangedSubview(starsCountLabel)
        vstack.addArrangedSubview(howManyWatchersCountLabel)
        vstack.addArrangedSubview(watchersCountLabel)
        vstack.addArrangedSubview(howManyForksCountLabel)
        vstack.addArrangedSubview(forksCountLabel)
        vstack.addArrangedSubview(howManyIssuesCountLabel)
        vstack.addArrangedSubview(issuesCountLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            vstack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vstack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            vstack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private let profileImageView = UIImageView()
    private let titleLabel = DetailRepositoryLabel(isDescriptionType: false)
    private let languageLabel = DetailRepositoryLabel(isDescriptionType: false)
    private let starsCountLabel = DetailRepositoryLabel(isDescriptionType: false)
    private let watchersCountLabel = DetailRepositoryLabel(isDescriptionType: false)
    private let forksCountLabel = DetailRepositoryLabel(isDescriptionType: false)
    private let issuesCountLabel = DetailRepositoryLabel(isDescriptionType: false)

    private let whatLanguageLabel = DetailRepositoryLabel(isDescriptionType: true)
    private let howManyStarsCountLabel = DetailRepositoryLabel(isDescriptionType: true)
    private let howManyWatchersCountLabel = DetailRepositoryLabel(isDescriptionType: true)
    private let howManyForksCountLabel = DetailRepositoryLabel(isDescriptionType: true)
    private let howManyIssuesCountLabel = DetailRepositoryLabel(isDescriptionType: true)

    private lazy var vstack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 15
        view.distribution = .equalSpacing
        return view
    }()

    private let scrollView = UIScrollView()
}

private class DetailRepositoryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(hex: "ff6600", alpha: 0.4)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(hex: "ff6600", alpha: 0.4)
    }

    init(isDescriptionType: Bool) {
        super.init(frame: .zero)
        if isDescriptionType {
            layer.cornerRadius = 10
            clipsToBounds = true
            backgroundColor = UIColor(hex: "ff6600", alpha: 0.4)
        } else {
            layer.cornerRadius = 10
            clipsToBounds = true
            backgroundColor = .white
        }
    }

    var padding = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var contentSize = super.sizeThatFits(size)
        contentSize.width += padding.left + padding.right
        contentSize.height += padding.top + padding.bottom
        return contentSize
    }
}
