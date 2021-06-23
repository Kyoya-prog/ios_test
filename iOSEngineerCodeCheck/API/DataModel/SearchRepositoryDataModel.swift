struct Repositories: Codable {
    let items: [Repository]

    private enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int

    let owner: Owner

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case language = "language"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner = "owner"
    }
}

struct Owner: Codable {
    let login: String

    let avatarUrl: String

    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}
