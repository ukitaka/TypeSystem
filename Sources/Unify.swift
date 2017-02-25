//
//  Unify.swift
//  TypeSystem
//
//  Created by Yuki Takahashi on 2017/02/24.
//
//

import Foundation

func unify(_ c: ConstraintSet) -> Substitution {
    guard let head = c.first else {
        return Substitution()
    }

    let (S, T) = (head.left, head.right)

    switch (S, T) {
    case (.typeVar(let a), .typeVar(let b)) where a == b:
        let equations = Array(c.dropFirst())
        return unify(ConstraintSet(equations: equations))

    case (.type(let a), .type(let b)) where a == b:
        let equations = Array(c.dropFirst())
        return unify(ConstraintSet(equations: equations))

    case (.typeVar, _) where !T.typeVars.contains(S):
        let sub = Substitution(typeVar: S, type: T)
        let cc = ConstraintSet(equations: Array(c.dropFirst()))
        return unify(sub.apply(constraintSet: cc)) • sub

    case (_, .typeVar) where !S.typeVars.contains(T):
        let sub = Substitution(typeVar: T, type: S)
        let cc = ConstraintSet(equations: Array(c.dropFirst()))
        return unify(sub.apply(constraintSet: cc)) • sub

    case (.arrow(let s1, let s2), .arrow(let t1, let t2)):
        var e = Array(c.dropFirst())
        e.append(Equation(left: s1, right: t1))
        e.append(Equation(left: s2, right: t2))
        return unify(ConstraintSet(equations: e))

    default:
        fatalError("Unification error. \(head)")
    }
}
