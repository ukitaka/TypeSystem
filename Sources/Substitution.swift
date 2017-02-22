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

    func lookup(_ typeVar: TypeVar) -> Type {
        assert(typeVar.isTypeVar)
        if let type = substitutions[typeVar] {
            return type
        } else {
            return typeVar
        }
    }

    func apply(_ type: Type) -> Type {
        switch type {
        case .typeVar:
            let u = lookup(type)
            if (type == u) {
                return type
            } else {
                return apply(u)
            }
        case .arrow(let from, let to):
            return .arrow(apply(from), apply(to))
        case .typeConstructor(let k, let ts):
            return .typeConstructor(k, ts.map(apply))
        }
    }

    func extend(typeVar: TypeVar, type: Type) -> Substitution {
        return Substitution(substitutions: substitutions + [typeVar:type])
    }
}
