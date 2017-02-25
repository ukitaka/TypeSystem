//
//  Constraint.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/23.
//
//

import Foundation

// MARK: - Constraint Set

struct ConstraintSet {
    fileprivate let equations: [Equation]

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
    init(arrayLiteral elements: Equation...) {
        self.equations = elements
    }
    
    init(_ elements: Equation...) {
        self.equations = elements
    }
}

// MARK: - Sequence

extension ConstraintSet: Sequence {
    func makeIterator() -> IndexingIterator<[Equation]> {
        return equations.makeIterator()
    }

    var first: Equation? {
        return equations.first
    }
}
