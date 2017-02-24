//
//  Constraint.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/23.
//
//

import Foundation

// MARK: - Equation

struct Equation {
    let left: Type
    let right: Type

    init(left: Type, right: Type) {
        self.left = left
        self.right = right
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

// MARK: - Constraint Set

struct ConstraintSet {
    let equations: [Equation]

    init(equation: Equation) {
        self.equations = [equation]
    }

    init(equations: [Equation]) {
        self.equations = equations
    }
}
