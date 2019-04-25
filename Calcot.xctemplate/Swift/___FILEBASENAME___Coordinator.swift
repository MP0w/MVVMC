//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit

class ___FILEBASENAMEASIDENTIFIER___: Coordinator {

    override func createRootViewController() -> UIViewController {
        let interactor = ___VARIABLE_productName___Interactor()
        let viewModel = ___VARIABLE_productName___ViewModel(model: interactor.model, interactor: interactor, coordinator: self)
        let viewController = ___VARIABLE_productName___ViewController(viewModel: viewModel)
        interactor.bind(with: viewController) { (interactor, viewController) in
            let viewModel = ___VARIABLE_productName___ViewModel(model: interactor.model, interactor: interactor, coordinator: self)
            viewController.configure(with: viewModel)
        }

        return viewController
    }
}
