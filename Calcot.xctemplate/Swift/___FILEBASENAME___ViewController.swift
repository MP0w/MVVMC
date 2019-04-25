//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit

class ___FILEBASENAMEASIDENTIFIER___: BaseViewController, UpdateableView {

    private var viewModel: ___VARIABLE_productName___ViewModel

    required init(viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        styleUI()
        layoutUI()
        configure(with: viewModel)
    }

    func configure(with viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
    }

    private func setupUI() {

    }

    private func styleUI() {

    }

    private func layoutUI() {

    }
}
