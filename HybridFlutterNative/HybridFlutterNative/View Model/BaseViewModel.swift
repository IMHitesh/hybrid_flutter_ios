//
//  BaseViewModel.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 18/01/23.
//

import Foundation

protocol BaseViewModelDelegate {
    func onFail(message: String)
    func reload()
}

extension BaseViewModelDelegate {
    func onFail(message: String){}
    func reload(){}
}


class BaseViewModel: Equatable {
    
    let id: Int
    init() {
        id = Int.random(in: 100000..<Int.max)
    }
    
    func addObserver(){
        if !AppViewModel.shared.arrObserver.contains(obj: self) {
            AppViewModel.shared.arrObserver.append(self)
        }
    }
    
    static func == (lhs: BaseViewModel, rhs: BaseViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func removeObserver(){
        AppViewModel.shared.arrObserver.removeAll { $0 == self}
    }
}
