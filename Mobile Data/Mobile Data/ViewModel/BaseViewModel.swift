//
//  BaseViewModel.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//
import Foundation
protocol ViewModelDelegate: class {
    func onSuccess()
    func onFailure(error: Error?)
}
class BaseViewModel: NSObject {
    //MARK: Properties
    weak var delegate: ViewModelDelegate?
    var unitTestcompletion: ((Bool, Any?) -> Void)?
    init(_ delegate: ViewModelDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
    func unitTestpreSetup(closure: @escaping ((Bool, Any?) -> Void)) {
        //MARK: Load webview
        self.unitTestcompletion = closure
    }
}
