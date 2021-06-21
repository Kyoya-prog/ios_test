import Foundation
import UIKit.UIViewController

class ModuleAssembler {
    static func assembleSearchRepositoryModule() -> UIViewController {
        // swiftlint:disable:next force_cast
        let viewController = UIStoryboard(name: "SearchRepository", bundle: nil).instantiateInitialViewController() as! SearchRepositoryViewController

        let model = SearchRepositoryModel()
        let presenter = SearchRepositoryPresenter()

        presenter.model = model
        presenter.output = viewController
        viewController.presenterInput = presenter

        return viewController
    }

    static func assembleDetailRepositoryModule(repository: Repository) -> UIViewController {
        // swiftlint:disable:next force_cast
        let viewController = UIStoryboard(name: "DetailRepository", bundle: nil).instantiateInitialViewController() as! DetailRepositoryViewController
        viewController.selectedRepository = repository

        return viewController
    }
}
