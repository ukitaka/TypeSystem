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

    func extend(typeVar: TypeVar, type: Type) -> Substitution {
        return Substitution(substitutions: substitutions.union([typeVar:type]))
    }
}
