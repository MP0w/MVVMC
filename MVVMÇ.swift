import Foundation
import UIKit
import Combine

protocol Interactor: class {
    associatedtype ModelType
    var model: ModelType { get }
    var modelPublisher: AnyPublisher<ModelType, Never> { get }
}

protocol UpdateableView {
    associatedtype ViewModelType

    var viewModelPublisher: ViewModelPublisher<ViewModelType> { get }
}

extension UpdateableView {
    var viewModel: ViewModelType {
        return viewModelPublisher.viewModel
    }
}

// MARK: Binding
extension Interactor {
    func viewModelPublisher<T>(_ factory: @escaping (_ interactor: Self, ModelType) -> T) -> ViewModelPublisher<T> {
        return ViewModelPublisher(
            initialValue: factory(self, model),
            publisher: AnyPublisher<T, Never>(modelPublisher.map { factory(self, $0) })
        )
    }
}

class ViewModelPublisher<T>: ObservableObject {
    @Published var viewModel: T
    private var cancellable: Any?

    init(initialValue: T, publisher: AnyPublisher<T, Never>) {
        self.viewModel = initialValue
        self.cancellable = publisher.sink(receiveValue: { [unowned self] viewModel in
            self.viewModel = viewModel
        })
    }
}

class Coordinator {
    private weak var _rootViewController: UIViewController?
    
    var rootViewController: UIViewController {
        return _rootViewController ?? createRootViewController()
    }

    func createRootViewController() -> UIViewController {
        fatalError("createRootViewController not implemented")
    }
}
