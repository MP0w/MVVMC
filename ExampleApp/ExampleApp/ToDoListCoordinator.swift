//
//  ToDoListCoordinator.swift
//  ExampleApp
//
//  Created by Alex Manzella on 25/04/2019.
//  Copyright © 2019 mpow. All rights reserved.
//

import Foundation
import UIKit

class ToDoListCoordinator: Coordinator {

    override func createRootViewController() -> UIViewController {
        let interactor = ToDoListInteractor()
        let viewModel = ToDoListViewModel(model: interactor.model, interactor: interactor, coordinator: self)
        let viewController = ToDoListViewController(viewModel: viewModel)
        interactor.bind(with: viewController) { (interactor, viewController) in
            let viewModel = ToDoListViewModel(model: interactor.model, interactor: interactor, coordinator: self)
            viewController.configure(with: viewModel)
        }

        return viewController
    }
}
