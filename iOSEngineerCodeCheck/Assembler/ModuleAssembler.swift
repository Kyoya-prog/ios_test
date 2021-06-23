import Foundation
import UIKit.UIViewController

class ModuleAssembler {
    static func assembleSearchRepositoryModule() -> UIViewController {
        let viewController = SearchRepositoryViewController()

        let model = SearchRepositoryModel()
        let presenter = SearchRepositoryPresenter()

        presenter.model = model
        presenter.output = viewController
        viewController.presenterInput = presenter

        return viewController
    }

    static func assembleDetailRepositoryModule(repository: Repository) -> UIViewController {
        let viewController = DetailRepositoryViewController()
        viewController.selectedRepository = repository

        return viewController
    }
}
