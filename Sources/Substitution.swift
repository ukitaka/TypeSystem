//
//  Substitution.swift
//  TypeInference
//
//  Created by Yuki Takahashi on 2017/02/22.
//
//

import Foundation

// MARK: - Substitution (σ)

/// Substitution (σ) is a finite mapping from type variable to type.
/// if σ = [ X ↦ T, Y ↦ S ]
/// then,
///  σ(X) = T
///  σ(Y) = S
///  σ(Z) = Z
///  σ(T) = T
///  σ(X → X) = σ(X) → σ(X) = T → T
///  σ(F[X]) = F[T]
///  σ(F[T]) = F[T]
///
struct Substitution {
    fileprivate let substitutions: [TypeVar: Type]

    init() {
        self.substitutions = [:]
    }

    init(substitutions: [TypeVar: Type]) {
        self.substitutions = substitutions
    }

    // MARK: - 

    var domain: [TypeVar] {
        return Array(substitutions.keys)
    }

    var range: [Type] {
        return Array(substitutions.values)
    }

    // MARK: - apply

    func lookup(typeVar: TypeVar) -> Type {
        assert(typeVar.isTypeVar)
        if let type = substitutions[typeVar] {
            return type
        } else {
            return typeVar
        }
    }

    func apply(type: Type) -> Type {
        switch type {
        case .typeVar:
            let lookedupType = lookup(typeVar: type)
            if (type == lookedupType) {
                return type
            } else {
                return apply(type: lookedupType)
            }

        case .arrow(let from, let to):
            return .arrow(apply(type: from), apply(type: to))

        case .type(let name):
            return .type(name)
        }
    }

    // MARK: - unify

    func unifies(equation: Equation) -> Bool {
        return apply(type: equation.left) == apply(type: equation.right)
    }

    func unifies(constraintSet: ConstraintSet) -> Bool {
        return constraintSet.equations
            .map(unifies)
            .reduce(true) { $0.0 && $0.1 }
    }
}
