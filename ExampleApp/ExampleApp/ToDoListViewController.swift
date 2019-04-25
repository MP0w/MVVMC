//
//  ToDoListViewController.swift
//  ExampleApp
//
//  Created by Alex Manzella on 25/04/2019.
//  Copyright © 2019 mpow. All rights reserved.
//

import Foundation
import UIKit

class ToDoListViewController: UITableViewController, UpdateableView {

    private var viewModel: ToDoListViewModel

    required init(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        refreshControl = UIRefreshControl()
        configure(with: viewModel)
        viewModel.load()
    }

    func configure(with viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        title = viewModel.title
        tableView.reloadData()
        if viewModel.isLoading {
            refreshControl?.beginRefreshing()
        } else {
            refreshControl?.endRefreshing()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.cellViewModels?[indexPath.row]
        return cell
    }
}
