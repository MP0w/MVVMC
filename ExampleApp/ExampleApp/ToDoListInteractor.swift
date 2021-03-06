//
//  ToDoListInteractor.swift
//  ExampleApp
//
//  Created by Alex Manzella on 25/04/2019.
//  Copyright © 2019 mpow. All rights reserved.
//

import Foundation

class ToDoListInteractor: Interactor {

    private(set) var model: LoadableModel<[ToDo]> = .none {
        didSet {
            modelDidUpdate?()
        }
    }

    var modelDidUpdate: (() -> Void)?

    func load() {
        model = model.byStartLoading()
        // Fake load!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let todos = [
                ToDo(name: "Renew passport", subTasks: nil),
                ToDo(name: "Grocery shopping", subTasks: [ToDo(name: "Apples", subTasks: nil), ToDo(name: "Bananas", subTasks: nil)]),
                ToDo(name: "Clean car", subTasks: nil),
                ToDo(name: "Book holidays", subTasks: nil),
                ToDo(name: "Cancel insurance", subTasks: nil),
            ]
        
            self.model = self.model.byStopLoading(newValue: todos)
        }
    }
}
