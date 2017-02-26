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

    func union(_ constraintSet: ConstraintSet) -> ConstraintSet {
        var equations = self.equations
        for eq in constraintSet.equations {
            guard equations.contains(eq) == false else {
                continue
            }
            equations.append(eq)
        }
        return ConstraintSet(equations: equations)
    }
}

// MARK: - Substitutable

extension ConstraintSet: Substitutable {
    func substitute(_ s: Substitution) -> ConstraintSet {
        return ConstraintSet(equations: self.map(s.apply))
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
