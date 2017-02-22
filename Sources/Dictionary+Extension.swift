//
//  Dictionary+Extension.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

func + <K, V>(lhs: [K: V], rhs: [K: V]) -> [K: V] {
    var newDictionary = lhs
    for (key, value) in rhs {
        newDictionary[key] = value
    }
    return newDictionary
}
