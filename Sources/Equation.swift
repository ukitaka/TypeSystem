//
//  Equation.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/25.
//
//

import Foundation

struct Equation {
    let left: Type
    let right: Type

    init(left: Type, right: Type) {
        self.left = left
        self.right = right
    }

    func swap() -> Equation {
        return Equation(left: right, right: left)
    }
}

// MARK: - Euqtable

extension Equation: Equatable {
    static func == (lhs: Equation, rhs: Equation) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right
    }
}

// MARK: - CustomStringConvertible

extension Equation: CustomStringConvertible {
    var description: String {
        return left.description + " = " + right.description
    }
}
