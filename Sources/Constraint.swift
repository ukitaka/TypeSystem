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

func unify(_ equations: [Equation]) -> Substitution {
    guard let head = equations.first else {
        return Substitution()
    }

    let (S, T) = (head.left, head.right)

    switch (S, T) {
    case (.typeVar(let a), .typeVar(let b)) where a == b:
        return unify(Array(equations.dropFirst()))

    case (.type(let a), .type(let b)) where a == b:
        return unify(Array(equations.dropFirst()))

    case (.typeVar, _) where !T.typeVars.contains(S):
        let sub = Substitution(typeVar: S, type: T)
        let c = ConstraintSet(equations: Array(equations.dropFirst()))
        return unify(sub.apply(constraintSet: c).equations) • sub

    case (_, .typeVar) where !S.typeVars.contains(T):
        let sub = Substitution(typeVar: T, type: S)
        let c = ConstraintSet(equations: Array(equations.dropFirst()))
        return unify(sub.apply(constraintSet: c).equations) • sub

    case (.arrow(let s1, let s2), .arrow(let t1, let t2)):
        var e = Array(equations.dropLast())
        e.append(Equation(left: s1, right: t1))
        e.append(Equation(left: s2, right: t2))
        return unify(e)

    default:
        fatalError("Unification error. \(head)")
    }
}
