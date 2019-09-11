//
//  ToDoListView.swift
//  ExampleApp
//
//  Created by Alex Manzella on 25/04/2019.
//  Copyright © 2019 mpow. All rights reserved.
//

import Foundation
import SwiftUI

struct ToDoListView: View, UpdateableView {
    @ObservedObject var viewModelPublisher: ViewModelPublisher<ToDoListViewModel>

    var body: some View {
        List(viewModel.cellViewModels, rowContent: { Text($0) })
            .onAppear(perform: viewModel.load)
    }
}

extension String: Identifiable {
    public var id: String {
        return self
    }
}
