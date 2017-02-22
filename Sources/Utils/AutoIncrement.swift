//
//  AutoIncrement.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

final class AutoIncrement {
    private static var current: Int = 0

    static func next() -> Int {
        defer { current = current + 1 }
        return current
    }
}
