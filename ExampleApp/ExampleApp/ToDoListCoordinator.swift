//
//  ToDoListCoordinator.swift
//  ExampleApp
//
//  Created by Alex Manzella on 25/04/2019.
//  Copyright © 2019 mpow. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class ToDoListCoordinator: Coordinator {

    override func createRootViewController() -> UIViewController {
        let interactor = ToDoListInteractor()
        let view = ToDoListView(viewModelPublisher: interactor.viewModelPublisher { ToDoListViewModel(model: $1, interactor: $0, coordinator: self)})
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
}
