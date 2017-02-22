//
//  Dictionary+Extension.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

extension Dictionary {
    func union(_ other: [Key: Value]) -> [Key: Value] {
        var newDictionary = self
        for (key, value) in other {
            newDictionary[key] = value
        }
        return newDictionary
    }
}
