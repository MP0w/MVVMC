//
//  ToDoListViewModel.swift
//  ExampleApp
//
//  Created by Alex Manzella on 25/04/2019.
//  Copyright © 2019 mpow. All rights reserved.
//

import Foundation

struct ToDoListViewModel {

    private let model: LoadableModel<[ToDo]>
    private let interactor: ToDoListInteractor
    private let coordinator: ToDoListCoordinator
    let cellViewModels: [String]?

    var title: String {
        return "ToDo"
    }
    
    var isLoading: Bool {
        guard case .loading = model else { return false }
        return true
    }

    init(model: LoadableModel<[ToDo]>, interactor: ToDoListInteractor, coordinator: ToDoListCoordinator) {
        self.model = model
        self.interactor = interactor
        self.coordinator = coordinator
        
        cellViewModels = model.value?.flatMap {
            return [$0.name] + ($0.subTasks?.map { " - \($0.name)" } ?? [])
        }
    }
    
    func load() {
        interactor.load()
    }
}
