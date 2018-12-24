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
    func loading(_ loading: Bool)
}
class BaseViewModel: NSObject {
    //MARK: Properties
    weak var delegate: ViewModelDelegate?
    init(_ delegate: ViewModelDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
}
