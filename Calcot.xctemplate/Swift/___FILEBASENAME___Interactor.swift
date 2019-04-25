//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation

class ___FILEBASENAMEASIDENTIFIER___: Interactor {

    private(set) var model: ___VARIABLE_modelclass___ {
        didSet {
            modelDidUpdate?()
        }
    }

    var modelDidUpdate: (() -> Void)?

}
