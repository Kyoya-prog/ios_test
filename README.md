# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の概要を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要作成時点では Xcode 11.4.1）
- Swift：基本最新の安定版（本概要作成時点では Swift 5.1）
- 開発ターゲット：基本最新の安定版（本概要作成時点では iOS 13.4）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 課題取り組み方法

Issues を確認した上、本プロジェクトを [**Duplicate** してください](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)（Fork しないようにしてください。必要ならプライベートリポジトリーにしても大丈夫です）。今後のコミットは全てご自身のリポジトリーで行ってください。

コードチェックの課題 Issue は全て [`課題`](https://github.com/yumemi/ios-engineer-codecheck/milestone/1) Milestone がついており、難易度に応じて Label が [`初級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A初級+milestone%3A課題)、[`中級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A中級+milestone%3A課題+) と [`ボーナス`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3Aボーナス+milestone%3A課題+) に分けられています。課題の必須／選択は下記の表とします：

|   | 初級 | 中級 | ボーナス
|--:|:--:|:--:|:--:|
| 新卒／未経験者 | 必須 | 選択 | 選択 |
| 中途／経験者 | 必須 | 必須 | 選択 |

課題が完成したら、リポジトリーのアドレスを教えてください。

# 使用したライブラリ
## SPM 
### HTTP通信
[Alamofire](https://github.com/Alamofire/Alamofire)
[Moya](https://github.com/Moya/Moya)
### 画像通信
[AlamofireImage](https://github.com/Alamofire/AlamofireImage)

## Carthage
### バナーメッセージ
[NotificationBanner](https://github.com/Daltron/NotificationBanner)

# UI
## リポジトリ検索画面

![Simulator Screen Shot - iPhone 12 Pro - 2021-06-23 at 23 37 17](https://user-images.githubusercontent.com/63186144/123260951-23764780-d531-11eb-86db-cb462ad7f281.png)

## リポジトリ詳細画面

![Simulator Screen Shot - iPhone 12 Pro - 2021-06-23 at 23 37 22](https://user-images.githubusercontent.com/63186144/123260965-2709ce80-d531-11eb-9051-1215beb1c2ad.png)

# 補足事項

アーキテクチャは機能がシンプルと言うこともあり、無駄なコードの複雑化を避けるため、シンプルなMVPアーキテクチャを採用しました。リポジトリ詳細画面については、プレゼンテーションロジックやビジネスロジックはなかったので、Viewのみの構成にしています。
　ライブラリの管理は、基本は  spmで行い、spm対応していないNottificationBannerとその依存ライブラリについてはCarthageで管理しています。
UIの開発はstoryboardではなく、コードベースで行いました。
コード解析ツールに[swiftlint](https://github.com/realm/SwiftLint)を用いています
