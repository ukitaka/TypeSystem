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

// MARK: - CustomStringConvertible

extension ConstraintSet: CustomStringConvertible {
    var description: String {
        return equations.map { $0.description }
            .joined(separator: "\n")
    }
}

// MARK: - ExpressibleByDictionaryLiteral

extension ConstraintSet: ExpressibleByArrayLiteral {
    typealias Element = Equation

    init(arrayLiteral elements: Equation...) {
        self.equations = elements
    }
    
    init(_ elements: Equation...) {
        self.equations = elements
    }
}
