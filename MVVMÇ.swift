import Foundation
import UIKit

protocol Interactor: class {
    associatedtype ModelType

    var model: ModelType { get }
    var modelDidUpdate: (() -> Void)? { get set }
}

protocol UpdateableView: class {
    associatedtype ViewModelType

    init(viewModel: ViewModelType)

    func configure(with viewModel: ViewModelType)
}

// MARK: Binding
extension Interactor {
    func bind<T: UpdateableView>(with viewController: T, factory: @escaping (_ interactor: Self, _ vc: T) -> Void) {
        modelDidUpdate = { [weak self, weak viewController] in
            guard let interactor = self, let viewController = viewController else {
                return
            }

            factory(interactor, viewController)
        }
    }
}