//
//  Array+Extension.swift
//  HybridFlutterNative
//
//  Created by Hitesh Surani on 18/01/23.
//

import Foundation

extension Array {
    func contains<T>(obj: T) -> Bool where T: Equatable {
        return !self.filter({$0 as? T == obj}).isEmpty
    }
    
    func find<T>(_obj: T.Type) -> T? {
        for object in self {
            if let castObj = object as? T{
                return castObj
            }
        }
        return nil
    }
}
